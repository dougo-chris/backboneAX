class Bx.Model.Base extends Backbone.Model
  constructor: (attributes, options) ->
    super(attributes, options)
    # allow overriding of the "contructed" method
    @constructed(attributes) if @constructed?

  fetch: (options = {}) ->
    @_conn_state = "connected"

    optionsSuccess = options.success
    options.success = (model, response) =>
      optionsSuccess(model, response) if optionsSuccess
      @onSuccess(model, response)

    optionsError = options.error
    options.error = (model, response) =>
      optionsError(model, response) if optionsError
      @onError(model, response)

    super(options)

  save: (attr, options = {}) ->
    @_conn_state = "connected"

    optionsSuccess = options.success
    options.success = (model, response) =>
      optionsSuccess(model, response) if optionsSuccess
      @onSuccess(model, response)

    optionsError = options.error
    options.error = (model, response) =>
      optionsError(model, response) if optionsError
      @onError(model, response)

    super(attr, options)

  destroy: (options = {}) ->
    @_conn_state = "connected"

    optionsSuccess = options.success
    options.success = (model, response) =>
      optionsSuccess(model, response) if optionsSuccess
      @onSuccess(model, response)

    optionsError = options.error
    options.error = (model, response) =>
      optionsError(model, response) if optionsError
      @onError(model, response)

    super(options)

  isError: ()->
    @_conn_state == "error"

  isConnected: () ->
    @_conn_state == "connected"


  onSuccess: (collection, response) ->
    @_conn_state = ""
    @trigger("connection", @)

  onError: (collection, response) ->
    @_conn_state = "error"
    @trigger("connection", @)

