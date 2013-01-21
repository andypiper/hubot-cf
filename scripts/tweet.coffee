# Description:
#   Displays last tweet from @cloudfoundry user
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot cf tweet - Show last tweet from @cloudfoundry Twitter account
#
# Notes:
#   None
#
# Author:
#   andypiper
#
module.exports = (robot) ->
  robot.respond /cf tweet/i, (msg) ->
   msg.http("http://api.twitter.com/1/statuses/user_timeline/cloudfoundry.json?count=1&include_rts=true")
    .get() (err, res, body) ->
      response = JSON.parse body
      if response[0]
       msg.send response[0]["text"]
      else
       msg.send "Something went wrong, deploy more birds!"
