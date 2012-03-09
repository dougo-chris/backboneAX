class Bx.Model.Base extends Backbone.Model

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
    @trigger("change:connection")    
  
  isConnected: () ->
    @_conn_state == "connected"


  getDate: (attr, format = null) ->
    value = @get(attr)
    return null unless value?
    switch format
      when "raw"
        value
      when "dateLong"
        Date.parseExact(value, "yyyyMMddHHmm").toString("dddd MMMM d, yyyy")
      when "dateUSA"
        Date.parseExact(value, "yyyyMMddHHmm").toString("MM/dd/yyyy")
      when "date"
        Date.parseExact(value, "yyyyMMddHHmm").toString("d MMM yy")
      when "timeLong"
        Date.parseExact(value, "yyyyMMddHHmm").toString("h:mm tt")
      when "time"
        Date.parseExact(value, "yyyyMMddHHmm").toString("HH:mm")
      when "dateTimeLong"
        Date.parseExact(value, "yyyyMMddHHmm").toString("dddd MMMM d, yyyy h:mm tt")
      else
        Date.parseExact(value, "yyyyMMddHHmm").toString("d MMM yyyy")
