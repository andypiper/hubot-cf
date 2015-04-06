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
#   Get the access token via `cf oauth-token` from the CLI. Leave off the 'bearer'.
#
# Author:
#   afeld

request = require('request')

token = process.env.HUBOT_CF_ACCESS_TOKEN || throw new Error("Please set HUBOT_CF_ACCESS_TOKEN.")

opts = {
  url: 'http://api.cf.18f.us/v2/events'
  json: true
  headers:
    Authorization: "bearer #{token}"
  qs:
    'order-direction': 'desc'
}

request opts, (error, response, body) ->
  console.log(body)


# module.exports = (robot) ->
