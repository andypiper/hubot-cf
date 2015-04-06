# Description:
#   Sends notifications of Cloud Foundry activity.
#
# Configuration:
#   HUBOT_CF_ACCESS_TOKEN
#
# Notes:
#   Get the access token via `cf oauth-token` from the CLI, including the 'bearer'.
#
# Author:
#   afeld

childProcess = require('child_process')
request = require('request')


# TODO use a static token
# token = process.env.HUBOT_CF_ACCESS_TOKEN || throw new Error("Please set HUBOT_CF_ACCESS_TOKEN.")

# hack to get the up-to-date bearer token
token = null
childProcess.exec 'cf oauth-token | tail -n 1', (error, stdout, stderr) ->
  token = stdout.toString()


# http://apidocs.cloudfoundry.org/205/events/list_app_update_events.html
getRequestOpts = (since) ->
  sinceStr = since.toISOString()
  {
    url: 'http://api.cf.18f.us/v2/events'
    json: true
    headers:
      Authorization: token
    useQuerystring: true
    qs:
      'order-direction': 'desc'
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



module.exports = (robot) ->
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
