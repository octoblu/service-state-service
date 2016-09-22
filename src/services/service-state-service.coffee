EtcdService = require './etcd-service.coffee'

class ServiceStateService
  constructor: ({ @etcdUri }) ->
    @etcdService = new EtcdService { @etcdUri }

  getKey: ({ namespace, service, key }, callback) =>
    etcdKey = "/#{namespace}/#{service}/#{key}"
    @etcdService.get etcdKey, { recursive: false }, (error, result) =>
      return callback error if error?
      callback null, result?.node?.value

  setKey: ({ namespace, service, key, value }, callback) =>
    etcdKey = "/#{namespace}/#{service}/#{key}"
    @etcdService.set etcdKey, value, (error) =>
      return callback error if error?
      callback null

  _createError: (code, message) =>
    error = new Error message
    error.code = code if code?
    return error

module.exports = ServiceStateService
