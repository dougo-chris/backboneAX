class Bx.View.Base extends Backbone.View
  
  constructor: (options) ->
    super(options)
    # allow overriding of the "contructed" method
    @constructed(options) if @constructed?
    
  remove: () ->
    super()
    # allow overriding of the "removed" method
    @removed() if @removed?

# SET & GET FORM FIELDS
  formSetText: (fieldName, modelOrValue, attrName) ->
    field = @$("##{fieldName}")
    value = if @_isModel(modelOrValue) then modelOrValue.get(attrName ? fieldName) else modelOrValue
 
    field.attr('value', value)

  formGetText: (fieldName, model, attrName) ->
    field = @$("##{fieldName}")
    value =  field.attr('value')
    
    if model?
      options = {}
      options[attrName ? fieldName] = value    
      model.set(options, {silent: true})
    return value

  formSetSelect: (fieldName, modelOrValue, attrName) ->
    field = @$("##{fieldName}")
    value = if @_isModel(modelOrValue) then modelOrValue.get(attrName ? fieldName) else modelOrValue
    
    field.find("option").removeAttr('selected')
    field.find("option[value='#{value}']").attr('selected', true)
        
  formGetSelect: (fieldName, model, attrName) ->
    field = @$("##{fieldName}")
    value = field.find('option:selected').val()

    if model?
      options = {}
      options[attrName ? fieldName] = value    
      model.set(options, {silent: true})
    return value
    
  formSetSelectMultiple: (fieldName, modelOrValue, attrName) ->
    field = @$("##{fieldName}")
    values = if @_isModel(modelOrValue) then modelOrValue.get(attrName ? fieldName) else modelOrValue    
    
    field.find("option").removeAttr('selected')
    if values?
      _.each values, (value) ->
        field.find("option[value='#{value}']").attr('selected', true)
        
  formGetSelectMultiple: (fieldName, model, attrName) ->
    field = @$("##{fieldName}")
    
    values = []
    _.each field.find('option'), (option) ->
      if $(option).is(':selected')
        values.push($(option).val())

    if model?
      options = {}
      options[attrName ? fieldName] = values    
      model.set(options, {silent: true})
    return values

  formSetCheckbox: (fieldName, modelOrValue, attrName) ->
    field = @$("##{fieldName}")
    value = if @_isModel(modelOrValue) then modelOrValue.get(attrName ? fieldName) else modelOrValue
    
    if value == true
      field.attr('checked', true)
    else
      field.removeAttr('checked')    
        
  formGetCheckbox: (fieldName, model, attrName) ->
    field = @$("##{fieldName}")
    value = field.is(':checked')

    if model?
      options = {}
      options[attrName ? fieldName] = value  
      model.set(options, {silent: true})    
    return value

# MODEL OR VALUE
  _isModel: (model) ->
    model? && typeof(model) == 'object'
