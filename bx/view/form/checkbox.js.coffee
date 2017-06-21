_.extend Bx.View.Base.prototype,
  formSetCheckbox: (fieldName, modelOrValue, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    value = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue

    if value == true
      field.attr('checked', true)
    else
      field.removeAttr('checked')

  formGetCheckbox: (fieldName, model = null, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    value = field.is(':checked')

    if model?
      model.setNestedValue(fieldName, value)

    return value
