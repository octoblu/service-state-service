shmock        = require 'shmock'
request       = require 'request'
enableDestroy = require 'server-destroy'
Server        = require '../../src/server'

describe 'Get Docker URL', ->
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
      .get '/v2/keys/octoblu/awesome-service/docker_url'
      .reply 200, {
        action: 'get'
        node:
          key: '/octoblu/awesome-service/docker_url'
          value: 'quay.io/octoblu/awesome-service:v1'
          modifiedIndex: 4
          createdIndex: 4
      }

    options =
      uri: '/octoblu/awesome-service/docker_url'
      baseUrl: "http://localhost:#{@serverPort}"
      auth:
        username: 'tester'
        password: 'iamatester'
      json: true

    request.get options, (error, @response, @body) =>
      done error

  it 'should return a 200', ->
    expect(@response.statusCode).to.equal 200

  it 'should return a docker_url', ->
    expect(@body).to.equal 'quay.io/octoblu/awesome-service:v1'
