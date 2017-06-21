_.extend Bx.View.Base.prototype,
  formSetNumber: (fieldName, modelOrValue, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    value = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue

    field.val("#{value}")

  formGetNumber: (fieldName, model = null, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    value = parseInt(field.val(), 10)
    value = 0 if _.isNaN(value)

    if model?
      model.setNestedValue(fieldName, value)

    return value