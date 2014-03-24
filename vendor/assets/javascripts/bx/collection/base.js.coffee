class Bx.Collection.Base extends Backbone.Collection

  constructor: (models, options = {}) ->
    super(models, options)
    # @models = []
    @fetchCalled = false

  fetch: (options = {}) ->
    @fetchCalled = true
    @_conn_state = "connected"

    optionsSuccess = options.success
    options.success = (collection, response) =>
      optionsSuccess(collection, response) if optionsSuccess
      @onSuccess(collection, response)

    optionsError = options.error
    options.error = (collection, response) =>
      optionsError(collection, response) if optionsError
      @onError(collection, response)

    super(options)

  fetchOnce: (options = {}) ->
    return if @fetchCalled
    @fetch(options)

  isConnected: ()->
    @_conn_state == "connected"

  isError: ()->
    @_conn_state == "error"

  isFetched: ()->
    @fetchCalled && !@isConnected()

  onSuccess: (collection, response) ->
    @_conn_state = ""
    @trigger("connection", @)

  onError: (collection, response) ->
    @_conn_state = "error"
    @trigger("connection", @)

