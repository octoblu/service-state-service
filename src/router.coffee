ServiceStateController = require './controllers/service-state-controller'

class Router
  constructor: ({@serviceStateService}) ->
    throw new Error 'Missing serviceStateService' unless @serviceStateService?

  route: (app) =>
    serviceStateController = new ServiceStateController {@serviceStateService}

    app.get '/:namespace/:service/:key', serviceStateController.getKey
    app.put '/:namespace/:service/:key', serviceStateController.setKey

module.exports = Router
