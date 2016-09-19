request       = require 'request'
Server        = require '../../src/server'

describe 'Set Non-Docker URL', ->
  beforeEach (done) ->
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
    @server.destroy()

  beforeEach (done) ->
    options =
      uri: '/octoblu/awesome-service/something'
      baseUrl: "http://localhost:#{@serverPort}"
      auth:
        username: 'tester'
        password: 'iamatester'
      json: true

    request.put options, (error, @response, @body) =>
      done error

  it 'should return a 422', ->
    expect(@response.statusCode).to.equal 422

