_.extend Bx.View.Base.prototype,
  formSetRadio: (fieldName, modelOrValue, $scope = null) ->
    value = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue

    _.each @$("input[name='#{fieldName}']"), (field) ->
      if $(field).val() == value
        $(field).prop('checked', true)
      else
        $(field).prop('checked', false)

  formGetRadio: (fieldName, model = null, $scope = null) ->
    field = _.find @$("input[name='#{fieldName}']"), (field) -> $(field).is(':checked')
    value = $(field).val()

    if model?
      model.setNestedValue(fieldName, value)

    return value
