# https://github.com/cloudfoundry/uaa/blob/master/docs/UAA-APIs.rst#access-token-administration-apis
# http://andreareginato.github.io/simple-oauth2/#getting-started/client-credentials-flow

module.exports = {
  clientId: ->
    process.env.HUBOT_CF_CLIENT_ID || throw new Error("Please set HUBOT_CF_CLIENT_ID.")

  clientSecret: ->
    process.env.HUBOT_CF_CLIENT_SECRET || throw new Error("Please set HUBOT_CF_CLIENT_SECRET.")

  site: ->
    # TODO make configurable
    process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';
    "https://#{@clientId()}:#{@clientSecret()}@uaa.cf.18f.us"

  credentials: ->
    {
      clientID: @clientId()
      clientSecret: @clientSecret()
      site: @site()
      useBasicAuthorizationHeader: true
      # TODO set endpoints
    }

  oauth2Instance: ->
    creds = @credentials()
    require('simple-oauth2')(creds)

  # TODO use promises
  fetchTokenObj: (callback) ->
    oauth2 = @oauth2Instance()
    # TODO check if needed
    opts = {
      client_id: 'cf'
      scope: 'uaa.none'
    }
    oauth2.client.getToken opts, (error, result) ->
      if error
        console.log('Access Token Error', error.message)
      else
        token = oauth2.accessToken.create(result)
        callback(token)
}
