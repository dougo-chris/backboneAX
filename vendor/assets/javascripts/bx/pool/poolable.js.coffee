class Bx.Poolable
  @reset: (name) ->
    return unless @_data?
    if name? 
      @_data[name] = null
    else
      @_data = {}

  @has: (name) ->
    return false unless @_data?
    @_data[name]?

  @get: (name, reset = false) ->
    @_data ||= {}
    if !@_data[name]? || reset
      @_data[name] = @_create(name)
    @_data[name]
    
  @_create: (name) ->
    "should be overridden"
  
