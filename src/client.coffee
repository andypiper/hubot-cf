deepExtend = require('deep-extend')
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
    allOpts = generalRequestOpts()
    deepExtend(allOpts, opts)

    if allOpts.path
      allOpts.url = @resolveUrl(opts.path)
      appOpts.path = null

    request(allOpts, callback)
}
