_.extend Backbone.View.prototype, 
  _isModel: (model) ->
    model? && typeof(model) == 'object'
            
  setTemplate: (model, $scope = null) ->
    fields = if $scope? then $("*[data-setter]", $scope) else @$("*[data-setter]")
    _.each fields, (field) =>    
      $field = $(field)
      setters= $field.attr("data-setter").split(";");
      _.each setters, (setter) =>
        setdata = setter.split(',')
        setdata.push("text") if (setdata.length == 1 ) 
        switch $.trim(setdata[1])
          when "id"
            @setTemplateId($.trim(setdata[0]), model, $scope, $field)
          when "text"
            @setTemplateText($.trim(setdata[0]), model, $scope, $field)
          when "date"
            @setTemplateDate($.trim(setdata[0]), model, $scope, $field)
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
          else
            @setTemplateText($.trim(setdata[0]), model, $scope, $field)

  setTemplateId: (fieldName, model, $scope, $field) ->
    value = if @_isModel(model) then model.get(fieldName) else model
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
 
    field.attr(id, value)
    
  setTemplateText: (fieldName, model, $scope, $field) ->
    value = if @_isModel(model) then model.get(fieldName) else model
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
 
    field.html(value)

  setTemplateDate: (fieldName, model, $scope, $field) ->
    value = if @_isModel(model) then model.getDate(fieldName) else model
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
 
    field.html(value)

  setTemplateBool: (fieldName, model, $scope, $field) ->
    value = if @_isModel(model) then model.get(fieldName) else model
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
        
    if value == true 
      field.addClass('truthy').removeClass('falsy')
    else
      field.addClass('falsy').removeClass('truthy')

  setTemplateArray: (fieldName, model, $scope, $field) ->
    values = if @_isModel(model) then model.get(fieldName) else model
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
 
    result = ""
    if values?
      _.each values, (value)-> 
        if result.length > 0 then result += ", "
        result += value
      
    field.html(result)
    
  setTemplateShow: (fieldName, model, $scope, $field) ->
    value = if @_isModel(model) then model.get(fieldName) else model
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    
    field.toggle(value == true)
    if value == true
      field.removeClass('hide')
    else
      field.addClass('hide')

  setTemplateHide: (fieldName, model, $scope, $field) ->
    value = if @_isModel(model) then model.get(fieldName) else model
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
    
    field.toggle(value != true)
    if value == true
      field.addClass('hide')
    else
      field.removeClass('hide')
       
  setTemplateImg: (fieldName, model, $scope, $field) ->
    value = if @_isModel(model) then model.get(fieldName) else model
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
 
    field.attr('src', value)

  setTemplateHref: (fieldName, model, $scope, $field) ->
    value = if @_isModel(model) then model.get('id') else model
    field = if $field? then $field else if $scope? then $("##{fieldName}", $scope) else @$("##{fieldName}")
     
    field.attr('href', "##{value}")
