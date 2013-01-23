# Description
#   Returns the status of CloudFoundry.com
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot cf-status - Returns CloudFoundry.com status information
#
# Notes:
#   None
#
# Author:
#   andypiper
#

module.exports = (robot) ->
  robot.respond /cf-status/i, (msg) ->
    msg.http("http://status.cloudfoundry.com/api/read/json?debug=1")
      .get() (err, res, body) ->
        switch res.statusCode
          when 200
            try
              json = JSON.parse(body)
              msg.send "   CF Status: #{json.tumblelog.title}"
            catch error
              msg.send "Pour more JSON in the tank"
          else
            msg.send "Cannot contact the status server. Could be a Tumblr thing."

# this needs to be ported to Tumblr v2 API
# http://www.tumblr.com/docs/en/api/v2#blog-info - needs API key
