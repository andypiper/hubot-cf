# https://github.com/cloudfoundry/uaa/blob/master/docs/UAA-APIs.rst#access-token-administration-apis
# http://andreareginato.github.io/simple-oauth2/#getting-started/client-credentials-flow

token = null

module.exports = {
  clientId: ->
    process.env.HUBOT_CF_CLIENT_ID || throw new Error("Please set HUBOT_CF_CLIENT_ID.")

  clientSecret: ->
    process.env.HUBOT_CF_CLIENT_SECRET || throw new Error("Please set HUBOT_CF_CLIENT_SECRET.")

  site: ->
    # TODO make configurable
    'https://login.cf.18f.us'

  credentials: ->
    {
      clientID: @clientId()
      clientSecret: @clientSecret()
      site: @site()
      # TODO set endpoints
    }

  oauth2Instance: ->
    creds = @credentials()
    require('simple-oauth2')(creds)

  # TODO use promises
  fetchToken: ->
    oauth2 = @oauth2Instance()
    oauth2.client.getToken({}, saveToken)

  getToken: ->
    token

  saveToken: (error, result) ->
    if error
      console.log('Access Token Error', error.message)
    token = oauth2.accessToken.create(result)
}
