_.extend Bx.View.Base.prototype,
  formSetSelect: (fieldName, modelOrValue, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    value = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue

    field.val(value)

  formGetSelect: (fieldName, model = null, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    value = field.find('option:selected').val()

    if model?
      model.setNestedValue(fieldName, value)

    return value

  formSetSelectMultiple: (fieldName, modelOrValue, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    values = if @_isModel(modelOrValue) then  modelOrValue.getNestedValue(fieldName) else modelOrValue

    field.find("option").removeAttr('selected')
    if values?
      _.each values, (value) ->
        field.find("option[value='#{value}']").attr('selected', true)

  formGetSelectMultiple: (fieldName, model, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    values = []
    _.each field.find('option'), (option) ->
      if $(option).is(':selected')
        values.push($(option).val())

    if model?
      model.setNestedValue(fieldName, values)

    return values

