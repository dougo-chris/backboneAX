_.extend Bx.View.Base.prototype,
_.extend Bx.View.Base.prototype,
  formSetDatePicker: (fieldName, modelOrValue, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    value = if @_isModel(modelOrValue) then $.rawToDate(modelOrValue.getNestedValue(fieldName)) else $.rawToDate(modelOrValue)

    field.datepicker('update', value)

  formGetDatePicker: (fieldName, model = null, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    date = field.datepicker('getDate')
    value = if "#{date}" == "Invalid Date" then '' else date

    if model?
      model.setNestedValue(fieldName, $.dateToDateRaw(value))

    return $.dateToDateRaw(value)
