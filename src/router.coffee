ServiceStateController = require './controllers/service-state-controller'

class Router
  constructor: ({@serviceStateService}) ->
    throw new Error 'Missing serviceStateService' unless @serviceStateService?

  route: (app) =>
    serviceStateController = new ServiceStateController {@serviceStateService}

    app.get '/hello', serviceStateController.hello
    # e.g. app.put '/resource/:id', someController.update

module.exports = Router
