# Description:
#   Sends notifications of Cloud Foundry activity.
#
# Dependencies:
#   "<module name>": "<module version>"
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


# token = process.env.HUBOT_CF_ACCESS_TOKEN || throw new Error("Please set HUBOT_CF_ACCESS_TOKEN.")

# hack to get the up-to-date token - requires Node 0.12+
token = childProcess.execSync('cf oauth-token | tail -n 1').toString()


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


getDeployEvents = (since, callback) ->
  opts = getRequestOpts(since)
  request opts, (error, response, data) ->
    callback(error, data.resources)


printDeployEvents = (since, callback) ->
  getDeployEvents since, (error, events) ->
    for event in events
      entity = event.entity
      # A mediocre proxy for an existing app being `push`ed, since it has false positives like new instances starting.
      if entity.metadata?.request?.state is 'STARTED'
        console.log("#{entity.actor_name} is deploying #{entity.actee_name}")


# poll for deployment events
lastCheckedAt = new Date()
setInterval(->
  console.log('Checking...')
  printDeployEvents(lastCheckedAt)
  lastCheckedAt = new Date()
, 5000)





# module.exports = (robot) ->
