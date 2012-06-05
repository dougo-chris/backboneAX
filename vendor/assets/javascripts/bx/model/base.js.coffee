class Bx.Model.Base extends Backbone.Model
  constructor: (attributes, options) ->
    super(attributes, options)      
    # allow overriding of the "contructed" method
    @constructed(attributes) if @constructed?
  
  fetch: (options = {}) ->
    @_connState("connected")
    
    optionsSuccess = options.success
    options.success = (model, response) =>
      @_connState()
      optionsSuccess(model, response) if optionsSuccess

    optionsError = options.error
    options.error = (model, response) =>
      @_connState()
      optionsError(model, response) if optionsError
      
    super(options)

  save: (attr, options = {}) ->
    @_connState("connected")
    
    optionsSuccess = options.success
    options.success = (model, response) =>
      @_connState()
      optionsSuccess(model, response) if optionsSuccess

    optionsError = options.error
    options.error = (model, response) =>
      @_connState()
      optionsError(model, response) if optionsError      
      
    super(attr, options)

  destroy: (options = {}) ->
    @_connState("connected")

    optionsSuccess = options.success
    options.success = (model, response) =>
      @_connState()
      optionsSuccess(model, response) if optionsSuccess

    optionsError = options.error
    options.error = (model, response) =>
      @_connState()
      optionsError(model, response) if optionsError
      
    super(options)

  _connState: (state = "") ->
    @_conn_state = state
    @trigger("connection", @)    
  
  isConnected: () ->
    @_conn_state == "connected"

  getDate: (attr, format = null) ->
    $.dateFormatRaw(@get(attr), format)
