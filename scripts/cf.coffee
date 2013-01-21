# Description
#   Some handy Cloud Foundry-related functions for hubot
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot cf core <base URI> - Returns Cloud Controller information for API endpoint
#
# Notes:
#   None
#
# Author:
#   andypiper
#

module.exports = (robot) ->
  robot.respond /cf core (.*)/i, (msg) ->
    apiEndpoint = escape(msg.match[1])
    msg.http("http://#{apiEndpoint}/info")
      .get() (err, res, body) ->
        switch res.statusCode
            when 200
                try
                  json = JSON.parse(body)
                  msg.send "   CF Core Name: #{json.description}\n
             product: #{json.name}\n
             version: #{json.version}\n
               build: #{json.build}\n"
                catch error
                  msg.send "Insufficient JSON ninjas available"
            else
                msg.send "Unable to process your request. Needs more ice cream."


# ideas TODO:
# add additional operations
# - list runtimes on core
# - .com platform status
# - get last tweet from @cloudfoundry
