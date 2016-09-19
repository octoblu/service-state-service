shmock        = require 'shmock'
request       = require 'request'
enableDestroy = require 'server-destroy'
Server        = require '../../src/server'

describe 'Set Docker URL', ->
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
    @getKey = @etcdServer
      .put '/v2/keys/octoblu/awesome-service/docker_url'
      .reply 204

    options =
      uri: '/octoblu/awesome-service/docker_url'
      baseUrl: "http://localhost:#{@serverPort}"
      auth:
        username: 'tester'
        password: 'iamatester'
      json:
        docker_url: 'quay.io/octoblu/awesome-service:v2'

    request.put options, (error, @response, @body) =>
      done error

  it 'should return a 204', ->
    expect(@response.statusCode).to.equal 204

