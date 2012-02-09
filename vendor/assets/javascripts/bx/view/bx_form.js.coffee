_.extend Backbone.View.prototype, 

  formSetText: (fieldName, model) ->
    value = if @_isModel(model) then model.get(fieldName) else model
    field = @$("##{fieldName}")
 
    field.attr('value', value)

  formGetText: (fieldName, model) ->
    field = @$("##{fieldName}")
    value =  field.attr('value')
    
    if model?
      options = {}
      options[fieldName] = value    
      model.set(options, {silent: true})
    return value

  formSetDate: (fieldName, model) ->
    value = if @_isModel(model) then model.getDate(fieldName) else model
    field = @$("##{fieldName}")
 
    field.attr('value', value)    

  formSetSelect: (fieldName, model) ->
    value = if @_isModel(model) then model.get(fieldName) else model
    field = @$("##{fieldName}")
    
    field.find("option").removeAttr('selected')
    field.find("option[value='#{value}']").attr('selected', true)
        
  formGetSelect: (fieldName, model) ->
    field = @$("##{fieldName}")    
    value = field.find('option:selected').val()

    if model?
      options = {}
      options[fieldName] = value    
      model.set(options, {silent: true})
    return value
    
  formSetSelectMultiple: (fieldName, model) ->
    values = if @_isModel(model) then model.get(fieldName) else model
    field = @$("##{fieldName}")
    
    field.find("option").removeAttr('selected')
    if values?
      _.each values, (value) ->
        field.find("option[value='#{value}']").attr('selected', true)
        
  formGetSelectMultiple: (fieldName, model) ->
    field = @$("##{fieldName}")
    
    values = []
    _.each field.find('option'), (option) ->
      if $(option).is(':selected')
        values.push($(option).val())

    if model?
      options = {}
      options[fieldName] = values    
      model.set(options, {silent: true})
    return values

  formSetCheckbox: (fieldName, model) ->
    value = if @_isModel(model) then model.get(fieldName) else model
    field = @$("##{fieldName}")
    
    if value == true
      field.attr('checked', true)
    else
      field.removeAttr('checked')    
        
  formGetCheckbox: (fieldName, model) ->
    field = @$("##{fieldName}")    
    value = field.is(':checked')

    if model?
      options = {}
      options[fieldName] = value  
      model.set(options, {silent: true})    
    return value

#private methods
  _isModel= (model) ->
    model? && typeof(model) == 'object'
      
