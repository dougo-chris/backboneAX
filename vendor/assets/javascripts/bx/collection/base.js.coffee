class Bx.Collection.Base extends Backbone.Collection

  constructor: (models, options = {}) ->
    super(models, options)
    # @models = []
    @fetchCalled = false

  fetch: (options = {}) ->
    @fetchCalled = true
    @_connState("connected")

    optionsSuccess = options.success
    options.success = (collection, response) =>
      @_connState()
      optionsSuccess(collection, response) if optionsSuccess

    optionsError = options.error
    options.error = (collection, response) =>
      @_connState("error")
      optionsError(collection, response) if optionsError

    super(options)

  fetchOnce: (options = {}) ->
    return if @fetchCalled
    @fetch(options)

  _connState: (state = "") ->
    @_conn_state = state
    @trigger("connection")

  isConnected: ()->
    @_conn_state == "connected"

  isError: ()->
    @_conn_state == "error"

  isFetched: ()->
    @fetchCalled && !@isConnected()
