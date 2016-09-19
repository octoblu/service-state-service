enableDestroy       = require 'server-destroy'
octobluExpress      = require 'express-octoblu'
basicauth           = require 'basicauth-middleware'
Router              = require './router'
ServiceStateService = require './services/service-state-service'
debug               = require('debug')('service-state-service:server')

class Server
  constructor: ({@logFn,@disableLogging,@port,@username,@password,@etcdUri})->
    throw new Error 'Missing username' unless @username?
    throw new Error 'Missing password' unless @password?
    throw new Error 'Missing etcdUri' unless @etcdUri?

  address: =>
    @server.address()

  run: (callback) =>
    app = octobluExpress({ @logFn, @disableLogging })

    app.use basicauth @username, @password
    serviceStateService = new ServiceStateService { @etcdUri }
    router = new Router {serviceStateService}

    router.route app

    @server = app.listen @port, callback
    enableDestroy @server

  stop: (callback) =>
    @server.close callback

  destroy: =>
    @server.destroy()

module.exports = Server
