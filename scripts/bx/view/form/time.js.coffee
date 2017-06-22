_.extend Bx.View.Base.prototype,
  formSetTimePicker: (fieldName, modelOrValue, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    value = if @_isModel(modelOrValue) then $.rawToTimeString(modelOrValue.getNestedValue(fieldName), 'rounded') else $.rawToTimeString(modelOrValue, 'rounded')

    field.val(value)

  formGetTimePicker: (fieldName, model = null, $scope = null) ->
    field = if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    value = null
    tmp1 = field.val().split(":")
    if tmp1.length == 2
      hour = parseInt($.trim(tmp1[0]), 10)
      tmp2 = $.trim(tmp1[1]).split(" ")
      if tmp2.length == 2
        minute = parseInt($.trim(tmp2[0]), 10)
        ext = $.trim(tmp2[1])
        unless _.isNaN(hour) || _.isNaN(minute)
          if ext.toUpperCase() == 'PM' && hour != 12
            hour += 12
          if hour < 10 && minute < 10
            value = "0#{hour}:0#{minute}:00"
          else if hour < 10
            value = "0#{hour}:#{minute}:00"
          else if minute < 10
            value = "#{hour}:0#{minute}:00"
          else
            value = "#{hour}:#{minute}:00"

    if model?
      model.setNestedValue(fieldName, value)

    return value
