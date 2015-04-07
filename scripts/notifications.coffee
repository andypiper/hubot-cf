# Description:
#   Sends notifications of Cloud Foundry activity.
#
# Configuration:
#   HUBOT_CF_CLIENT_ID
#   HUBOT_CF_CLIENT_SECRET
#
# Notes:
#   Create the client credentials via `uaac client add hubot-cf --scope uaa.none`
#
# Author:
#   afeld

childProcess = require('child_process')
request = require('request')
credentials = require('../src/credentials')

credentials.fetchToken()


# http://apidocs.cloudfoundry.org/205/events/list_app_update_events.html
getRequestOpts = (since) ->
  token = credentials.getToken()
  sinceStr = since.toISOString()

  {
    url: 'http://api.cf.18f.us/v2/events'
    json: true
    headers:
      Authorization: token
    useQuerystring: true
    qs:
      q: [
        "timestamp>#{sinceStr}"
        'type:audit.app.update'
      ]
  }


getUpdateEvents = (since, callback) ->
  opts = getRequestOpts(since)
  request opts, (error, response, data) ->
    callback(error, data.resources)


isDeploy = (event) ->
  # a mediocre proxy for an existing app being `push`ed, since it has false positives like new instances starting
  event.entity.metadata?.request?.state is 'STARTED'


getDeployEntities = (since, callback) ->
  getUpdateEvents since, (error, events) ->
    if error
      callback(error)
    else
      entities = (event.entity for event in events when isDeploy(event))
      callback(null, entities)

notifyForDeploys = (robot) ->
  # poll for deployment events
  lastCheckedAt = new Date()

  setInterval(->
    getDeployEntities lastCheckedAt, (error, entities) ->
      for entity in entities
        # TODO map to particular rooms based on organization_guid
        envelope = {room: 'cf-notifications'}
        robot.send(envelope, "#{entity.actor_name} is deploying #{entity.actee_name}")

    lastCheckedAt = new Date()
  , 5000)


module.exports = (robot) ->
  notifyForDeploys(robot)
