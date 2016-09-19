class ServiceStateController
  constructor: ({@serviceStateService}) ->
    throw new Error 'Missing serviceStateService' unless @serviceStateService?

  getKey: (request, response) =>
    { namespace, service, key } = request.params
    return response.sendStatus(422) unless key == 'docker_url'

    @serviceStateService.getKey { namespace, service, key }, (error, value) =>
      return response.sendError(error) if error?
      return response.sendStatus(404) unless value?
      response.status(200).send value

  setKey: (request, response) =>
    { namespace, service, key } = request.params
    { docker_url } = request.body
    return response.sendStatus(422) unless key == 'docker_url'
    return response.sendStatus(422) unless docker_url?

    value = docker_url
    @serviceStateService.setKey { namespace, service, key, value }, (error) =>
      return response.sendError(error) if error?
      response.sendStatus(204)

  restart: (request, response) =>
    { namespace, service } = request.params
    key = 'restart'
    value = new Date().toString()
    @serviceStateService.setKey { namespace, service, key, value }, (error) =>
      return response.sendError(error) if error?
      response.sendStatus(204)

module.exports = ServiceStateController
