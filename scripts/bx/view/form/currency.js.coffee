_.extend Bx.View.Base.prototype,
  formSetCurrency: (fieldName, modelOrValue, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    value = if @_isModel(modelOrValue) then $.rawToCurrencyString(modelOrValue.getNestedValue(fieldName)) else $.rawToCurrencyString(modelOrValue)

    field.val(value)

  formGetCurrency: (fieldName, model = null, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    field.formatCurrency()
    tmp1 = field.val().replace(/[^\-^0-9^\.]+/g, '').split(".")
    value = null
    if tmp1.length == 1
      value = parseInt(tmp1[0], 10)
      value = 0 if _.isNaN(value)
    else if tmp1.length == 2
      dollars = parseInt(tmp1[0], 10)
      dollars = 0 if _.isNaN(dollars)
      cents = parseInt(tmp1[1], 10)
      cents = 0 if _.isNaN(cents)
      value = dollars * 100 + cents

    if model?
      model.setNestedValue(fieldName, $.numberToCurrencyRaw(value))

    return $.numberToCurrencyRaw(value)

