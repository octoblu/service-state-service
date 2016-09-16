class ServiceStateController
  constructor: ({@serviceStateService}) ->
    throw new Error 'Missing serviceStateService' unless @serviceStateService?

  hello: (request, response) =>
    {hasError} = request.query
    @serviceStateService.doHello {hasError}, (error) =>
      return response.sendError(error) if error?
      response.sendStatus(200)

module.exports = ServiceStateController
