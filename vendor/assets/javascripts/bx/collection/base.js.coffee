class Bx.Collection.Base extends Backbone.Collection

  constructor: (options = {}) ->
    super(options)
    @models = []
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
      @_connState()
      optionsError(collection, response) if optionsError
    
    super(options)

  fetchOnce: (options = {}) ->
    return if @fetchCalled
    @fetch(options)
    
  _connState: (state = "") ->
    @_conn_state = state
    @trigger("change:connection")    
  
  isConnected: ()->
    @_conn_state == "connected"

  isFetched: ()->
    @fetchCalled && !@isConnected()
