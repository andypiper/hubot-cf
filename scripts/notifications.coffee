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

opts = {
  url: 'http://api.cf.18f.us/v2/events'
  json: true
  headers:
    Authorization: token
  qs:
    'order-direction': 'desc'
}

request opts, (error, response, body) ->
  console.log(body)


# module.exports = (robot) ->
