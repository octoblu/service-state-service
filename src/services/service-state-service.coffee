_    = require 'lodash'
url  = require 'url'
Etcd = require 'node-etcd'

class ServiceStateService
  constructor: ({ @etcdUri }) ->

  getKey: ({ namespace, service, key }, callback) =>
    etcd = @_getEtcd()
    etcdKey = "/#{namespace}/#{service}/#{key}"
    etcd.get etcdKey, (error, result) =>
      return callback error if error?
      callback null, result?.node?.value

  setKey: ({ namespace, service, key, value }, callback) =>
    etcd = @_getEtcd()
    etcdKey = "/#{namespace}/#{service}/#{key}"
    etcd.set etcdKey, value, (error) =>
      return callback error if error?
      callback null

  _getEtcd: =>
    return new Etcd @_getPeers()

  _getPeers: =>
    return unless @etcdUri?
    peers = @etcdUri.split ','
    return _.map peers, (peer) =>
      parsedUrl = url.parse peer
      return parsedUrl.host

  _createError: (code, message) =>
    error = new Error message
    error.code = code if code?
    return error

module.exports = ServiceStateService
