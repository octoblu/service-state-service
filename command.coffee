_             = require 'lodash'
Server        = require './src/server'

class Command
  constructor: ->
    @serverOptions = {
      port:           process.env.PORT || 80
      disableLogging: process.env.DISABLE_LOGGING == "true"
      username:       process.env.USERNAME
      password:       process.env.PASSWORD
      etcdUri:        process.env.ETCD_URI
    }

  panic: (error) =>
    console.error error.stack
    process.exit 1

  run: =>
    @panic new Error('Missing ETCD_URI') if _.isEmpty @serverOptions.etcdUri
    @panic new Error('Missing USERNAME') if _.isEmpty @serverOptions.username
    @panic new Error('Missing PASSWORD') if _.isEmpty @serverOptions.password

    server = new Server @serverOptions
    server.run (error) =>
      return @panic error if error?

      {address,port} = server.address()
      console.log "ServiceStateService listening on port: #{port}"

    process.on 'SIGTERM', =>
      console.log 'SIGTERM caught, exiting'
      return process.exit 0 unless server?.stop?
      server.stop =>
        process.exit 0

command = new Command()
command.run()
