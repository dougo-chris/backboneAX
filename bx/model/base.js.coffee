class Bx.Model.Base extends Backbone.Model

  @include: (mixins...) ->
    throw new Error('include(mixins...) requires at least one mixin') unless mixins and mixins.length > 0

    for mixin in mixins
      for key, value of mixin
        @::[key] = value unless key is 'included'

      mixin.included?.apply(@)
    this

  constructor: (attributes, options) ->
    super(attributes, options)
    # allow overriding of the "contructed" method
    @constructed(attributes) if @constructed?

  fetch: (options = {}) ->
    @_conn_state = "connected"
    @trigger('connection')

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
    @trigger('connection')

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
    @trigger('connection')

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

  onSuccess: (model, response) ->
    @_conn_state = ""
    @trigger("connection", @)

  onError: (model, response) ->
    @_conn_state = "error"
    @trigger("connection", @)

