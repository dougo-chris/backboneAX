_.extend Bx.View.Base.prototype,
  formSetText: (fieldName, modelOrValue, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    value = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue

    field.val(value)

  formGetText: (fieldName, model = null, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    value = field.val()

    if model?
      model.setNestedValue(fieldName, value)

    return value