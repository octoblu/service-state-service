shmock        = require 'shmock'
request       = require 'request'
enableDestroy = require 'server-destroy'
Server        = require '../../src/server'

describe 'Restart', ->
  beforeEach (done) ->
    @etcdServer = shmock 0xbabe
    enableDestroy @etcdServer

    @logFn = sinon.spy()
    serverOptions =
      port: undefined,
      disableLogging: true
      logFn: @logFn
      username: 'tester'
      password: 'iamatester'
      etcdUri:  "http://localhost:#{0xbabe}"

    @server = new Server serverOptions

    @server.run =>
      @serverPort = @server.address().port
      done()

  afterEach ->
    @etcdServer.destroy()
    @server.destroy()

  beforeEach (done) ->
    @setKey = @etcdServer
      .put '/v2/keys/octoblu/awesome-service/restart'
      .reply 204

    options =
      uri: '/octoblu/awesome-service/restart'
      baseUrl: "http://localhost:#{@serverPort}"
      auth:
        username: 'tester'
        password: 'iamatester'
      json: true

    request.put options, (error, @response, @body) =>
      done error

  it 'should return a 204', ->
    expect(@response.statusCode).to.equal 204

  it 'should call set key', ->
    @setKey.done()

