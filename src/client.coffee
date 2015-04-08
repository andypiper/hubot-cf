deepExtend = require('deep-extend')
request = require('request')
credentials = require('../src/credentials')


# TODO make configurable
apiOrigin = 'http://api.cf.18f.us'


module.exports = {
  resolveUrl: (path) ->
    apiOrigin + path

  generalRequestOpts: (accessToken) ->
    {
      json: true
      headers:
        Authorization: "Bearer #{accessToken}"
      useQuerystring: true
    }

  call: (opts, callback) ->
    credentials.fetchTokenObj (token) =>
      allOpts = @generalRequestOpts(token.token.access_token)
      deepExtend(allOpts, opts)

      if allOpts.path
        allOpts.url = @resolveUrl(opts.path)
        delete allOpts.path

      request(allOpts, callback)
}
