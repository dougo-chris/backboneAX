_.extend Bx.View.Base.prototype,
  # SET TEMPLATE VALUES
  setTemplate: (model, $scope = null) ->
    fields = if $scope? then $("*[data-setter]", $scope) else @$("*[data-setter]")
    _.each fields, (field) =>
      $field = $(field)
      setters= $field.attr("data-setter").split(",");
      _.each setters, (setter) =>
        setdata = setter.split(':')
        setdata.push("text") if (setdata.length == 1 )
        switch $.trim(setdata[1])
          when "id"
            @setTemplateId($.trim(setdata[0]), model, $scope, $field)
          when "text"
            @setTemplateText($.trim(setdata[0]), model, $scope, $field)
          when "bool"
            @setTemplateBool($.trim(setdata[0]), model, $scope, $field)
          when "array"
            @setTemplateArray($.trim(setdata[0]), model, $scope, $field)
          when  "show"
            @setTemplateShow($.trim(setdata[0]), model, $scope, $field)
          when  "hide"
            @setTemplateHide($.trim(setdata[0]), model, $scope, $field)
          when  "img"
            @setTemplateImg($.trim(setdata[0]), model, $scope, $field)
          when  "href"
            @setTemplateHref($.trim(setdata[0]), model, $scope, $field)
          when  "class"
            @setTemplateClass($.trim(setdata[0]), model, $scope, $field)
          when  "data"
            @setTemplateData($.trim(setdata[0]), model, $scope, $field)
          when  "date"
            @setTemplateDate($.trim(setdata[0]), model, $scope, $field)
          when  "dateShort"
            @setTemplateDateShort($.trim(setdata[0]), model, $scope, $field)
          when  "dateMedium"
            @setTemplateDateMedium($.trim(setdata[0]), model, $scope, $field)
          when  "dateLong"
            @setTemplateDateLong($.trim(setdata[0]), model, $scope, $field)
          when  "time"
            @setTemplateTime($.trim(setdata[0]), model, $scope, $field)
          when  "durationMin"
            @setTemplateDurationMin($.trim(setdata[0]), model, $scope, $field)
          when  "durationSec"
            @setTemplateDurationSec($.trim(setdata[0]), model, $scope, $field)
          when  "currency"
            @setTemplateCurrency($.trim(setdata[0]), model, $scope, $field)
          when  "dollar"
            @setTemplateDollar($.trim(setdata[0]), model, $scope, $field)
          when  "percent"
            @setTemplatePercent($.trim(setdata[0]), model, $scope, $field)
          when  "number"
            @setTemplateNumber($.trim(setdata[0]), model, $scope, $field)
          else
            @setTemplateOther?($.trim(setdata[1]), $.trim(setdata[0]), model, $scope, $field)

  # ID
  setTemplateId: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.attr(id, value)

  # TEXT
  setTemplateText: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.html(value)

  # TRUTHY / FALSY
  setTemplateBool: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    value = '' unless value?
    match = if $field.attr("data-matcher")? then "#{value}" == $field.attr("data-matcher") else value
    if match
      field.addClass('truthy').removeClass('falsy')
    else
      field.addClass('falsy').removeClass('truthy')

  # ARRAYS
  setTemplateArray: (fieldName, modelOrValue, $scope, $field) ->
    values = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    result = ""
    if values?
      _.each values, (value)->
        if result.length > 0 then result += ", "
        result += value

    field.html(result)

  # SHOW
  setTemplateShow: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    value = '' unless value?
    match = if $field.attr("data-matcher")? then "#{value}" == $field.attr("data-matcher") else value
    field.toggle(match)
    if match
      field.removeClass('hide')
    else
      field.addClass('hide')

  # HIDE
  setTemplateHide: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    value = '' unless value?
    match = if $field.attr("data-matcher")? then "#{value}" == $field.attr("data-matcher") else value
    field.toggle(!match)
    if match
      field.addClass('hide')
    else
      field.removeClass('hide')

  # IMG
  setTemplateImg: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.attr('src', value)

  # HREF
  setTemplateHref: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.attr('href', value)

  # Class
  setTemplateClass: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.addClass(value)

  # DATA
  setTemplateData: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.attr("data-#{fieldName}", value)

  # DATE
  setTemplateDate: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then $.rawToDateString(modelOrValue.getNestedValue(fieldName), 'default') else $.rawToDateString(modelOrValue, 'default')
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.html(value)

  setTemplateDateShort: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then $.rawToDateString(modelOrValue.getNestedValue(fieldName), 'short') else $.rawToDateString(modelOrValue, 'short')
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.html(value)

  setTemplateDateMedium: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then $.rawToDateString(modelOrValue.getNestedValue(fieldName), 'medium') else $.rawToDateString(modelOrValue, 'medium')
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.html(value)

  setTemplateDateLong: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then $.rawToDateString(modelOrValue.getNestedValue(fieldName), 'medium') else $.rawToDateString(modelOrValue, 'long')
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.html(value)

  # TIME
  setTemplateTime: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then $.rawToTimeString(modelOrValue.getNestedValue(fieldName), 'short') else $.rawToTimeString(modelOrValue, 'short')
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.html(value)

  setTemplateDurationMin: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then $.rawToTimeString(modelOrValue.getNestedValue(fieldName), 'durationMin') else $.rawToTimeString(modelOrValue, 'durationMin')
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.html(value)

  setTemplateDurationSec: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then $.rawToTimeString(modelOrValue.getNestedValue(fieldName), 'durationSec') else $.rawToTimeString(modelOrValue, 'durationSec')
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.html(value)

  setTemplateCurrency: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then $.rawToCurrencyString(modelOrValue.getNestedValue(fieldName)) else $.rawToCurrencyString(modelOrValue)
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.html(value)

  setTemplateDollar: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then $.rawToCurrencyString(modelOrValue.getNestedValue(fieldName), 'dollar') else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.html(value)

  setTemplatePercent: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then "#{modelOrValue.getNestedValue(fieldName)}%" else "#{modelOrValue}%"
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.html(value)

  setTemplateNumber: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.getNestedValue(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.html("#{value}".replace(/\B(?=(\d{3})+(?!\d))/g, ","))
