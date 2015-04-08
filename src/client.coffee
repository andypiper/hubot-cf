deepExtend = require('deep-extend')
request = require('request')
credentials = require('../src/credentials')


credentials.fetchToken()
# TODO make configurable
apiOrigin = 'http://api.cf.18f.us'


module.exports = {
  resolveUrl: (path) ->
    apiOrigin + path

  generalRequestOpts: ->
    token = credentials.getToken()
    {
      json: true
      headers:
        Authorization: token
      useQuerystring: true
    }

  get: (opts, callback) ->
    allOpts = @generalRequestOpts()
    deepExtend(allOpts, opts)

    if allOpts.path
      allOpts.url = @resolveUrl(opts.path)
      allOpts.path = null

    request(allOpts, callback)
}
