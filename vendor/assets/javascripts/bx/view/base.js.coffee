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
          when  "data"
            @setTemplateData($.trim(setdata[0]), model, $scope, $field)
          else
            @setTemplateOther?($.trim(setdata[1]), $.trim(setdata[0]), model, $scope, $field)

  setTemplateId: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.get(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.attr(id, value)

  setTemplateText: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.get(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.html(value)

  setTemplateBool: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.get(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    if value == true
      field.addClass('truthy').removeClass('falsy')
    else
      field.addClass('falsy').removeClass('truthy')

  setTemplateArray: (fieldName, modelOrValue, $scope, $field) ->
    values = if @_isModel(modelOrValue) then modelOrValue.get(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    result = ""
    if values?
      _.each values, (value)->
        if result.length > 0 then result += ", "
        result += value

    field.html(result)

  setTemplateShow: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.get(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.toggle(value == true)
    if value == true
      field.removeClass('hide')
    else
      field.addClass('hide')

  setTemplateHide: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.get(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.toggle(value != true)
    if value == true
      field.addClass('hide')
    else
      field.removeClass('hide')

  setTemplateImg: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.get(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.attr('src', value)

  setTemplateHref: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.get(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.attr('href', value)

  setTemplateData: (fieldName, modelOrValue, $scope, $field) ->
    value = if @_isModel(modelOrValue) then modelOrValue.get(fieldName) else modelOrValue
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")

    field.attr("data-#{fieldName}", value)
# MODEL OR VALUE
  _isModel: (model) ->
    model? && typeof(model) == 'object'
