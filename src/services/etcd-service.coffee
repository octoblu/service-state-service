_       = require 'lodash'
url     = require 'url'
request = require 'request'

class EtcdService
  constructor: ({ @etcdUri }) ->
    @apiVersion = '/v2'

  get: (key, { recursive }, callback) =>
    @_request {
      method: 'GET',
      path: "/keys/#{@_stripSlashPrefix(key)}",
      options: { recursive }
    }, callback

  set: (key, value, callback) =>
    @_request {
      method: 'PUT',
      path: "/keys/#{@_stripSlashPrefix(key)}",
      options: {}
      form: { value }
    }, callback

  _request: ({ method, path, options, form }, callback) =>
    baseUrl = @_getHost()
    qs = _.omit options, 'maxRetries'
    clientOptions = _.pick options, 'maxRetries'
    requestOptions = {
      method,
      baseUrl,
      uri: "#{@apiVersion}#{path}"
      qs,
      clientOptions,
      form,
      followAllRedirects: true,
      json: true,
    }
    request requestOptions, (error, response, body) =>
      return callback error if error?
      return callback body if response.statusCode > 399
      callback null, body

  _stripSlashPrefix: (key='') =>
    key.replace /^\//, ''

  _getHost: =>
    return _.sample @_getHosts()

  _getHosts: =>
    hosts = @etcdUri
    hosts = @etcdUri.split(',') unless _.isArray hosts
    return _.map hosts, (host) =>
      hostUrl = url.parse(host)
      return url.format {
        hostname: hostUrl.hostname,
        protocol: 'http'
        port: hostUrl.port,
        slashes: true,
      }

module.exports = EtcdService
