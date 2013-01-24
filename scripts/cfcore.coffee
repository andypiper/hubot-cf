# Description
#   Useful Cloud Foundry Core-related functions for hubot
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot cf-core <base URI> - Returns Cloud Controller information for API endpoint
#
# Notes:
#   None
#
# Author:
#   andypiper
#
mu = require 'mu2'
util = require 'util'
_ = require 'underscore'

mu.root = "#{__dirname}/../templates";

module.exports = (robot) ->
  robot.respond /cf-core (.*)/i, (msg) ->
    apiEndpoint = escape(msg.match[1])
    msg.http("http://#{apiEndpoint}/info")
      .get() (err, res, body) ->
        switch res.statusCode
          when 200
            try
              json = JSON.parse(body)

              res = ''
              frameworks = []
              runtimes = []

              for x of json.frameworks
                frameworks.push json.frameworks[x]

              json.frameworks = frameworks

              _.each frameworks, (f) ->
                _.each f.runtimes, (r) ->
                  runtime_names = _.map runtimes, (rn) ->
                    rn.name

                  runtimes.push r if not _.contains runtime_names, r.name

              json.runtimes = runtimes
              json.frameworks = frameworks

              stream = mu.compileAndRender('cf-core', json)
              stream.on 'data', (data) ->
                res = res + data.toString()
              stream.on 'end', () ->
                msg.send res

            catch error
              # msg.send error
              msg.send "Insufficient JSON ninjas available"
          else
              msg.send "Unable to process your request. Needs more ice cream."



# ideas TODO:
# add additional operations
# - list runtimes on core
