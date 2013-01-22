# Description:
#   Displays most recent tweet from @cloudfoundry user
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot cf-tweet - Show most recent tweet from @cloudfoundry Twitter account
#
# Notes:
#   None
#
# Author:
#   andypiper
#

module.exports = (robot) ->
  robot.respond /cf-tweet/i, (msg) ->
    msg.http("http://api.twitter.com/1/statuses/user_timeline/cloudfoundry.json?count=1&include_rts=true")
      .get() (err, res, body) ->
        response = JSON.parse body
        if response[0]
          tweetid = response[0]["id_str"]
          msg.send "http://twitter.com/cloudfoundry/status/#{tweetid}"
          msg.send response[0]["text"]
        else
          msg.send "Something went wrong, deploy more birds!"
