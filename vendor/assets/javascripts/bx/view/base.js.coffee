class Bx.View.Base extends Backbone.View
  
  constructor: (options) ->
    super(options)
    @_views = []
    
    # allow overriding of the "contructed" method
    @constructed(options) if @constructed?
    
  remove: () ->
    super()
    _.each @_views, (view) ->
      view.remove()  
    
    # allow overriding of the "removed" method
    @removed() if @removed?

# CHILD VIEWS
  createView: (klass, options = {}) ->
    view = new klass(options)    
    @_views.push(view)  
    return view
  
  removeView: (view) ->
    view.remove()  
    @_views = _.reject @_views, (object) ->
      object == view
    return null

# SET TEMPLATE VALUES
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

# SET & GET FORM FIELDS
  formSetText: (fieldName, model) ->
    value = if @_isModel(model) then model.get(fieldName) else model
    field = @$("##{fieldName}")
 
    field.attr('value', value)

  formGetText: (fieldName, model) ->
    field = @$("##{fieldName}")
    value =  field.attr('value')
    
    if model?
      options = {}
      options[fieldName] = value    
      model.set(options, {silent: true})
    return value

  formSetDate: (fieldName, model) ->
    value = if @_isModel(model) then model.getDate(fieldName) else model
    field = @$("##{fieldName}")
 
    field.attr('value', value)    

  formSetSelect: (fieldName, model) ->
    value = if @_isModel(model) then model.get(fieldName) else model
    field = @$("##{fieldName}")
    
    field.find("option").removeAttr('selected')
    field.find("option[value='#{value}']").attr('selected', true)
        
  formGetSelect: (fieldName, model) ->
    field = @$("##{fieldName}")    
    value = field.find('option:selected').val()

    if model?
      options = {}
      options[fieldName] = value    
      model.set(options, {silent: true})
    return value
    
  formSetSelectMultiple: (fieldName, model) ->
    values = if @_isModel(model) then model.get(fieldName) else model
    field = @$("##{fieldName}")
    
    field.find("option").removeAttr('selected')
    if values?
      _.each values, (value) ->
        field.find("option[value='#{value}']").attr('selected', true)
        
  formGetSelectMultiple: (fieldName, model) ->
    field = @$("##{fieldName}")
    
    values = []
    _.each field.find('option'), (option) ->
      if $(option).is(':selected')
        values.push($(option).val())

    if model?
      options = {}
      options[fieldName] = values    
      model.set(options, {silent: true})
    return values

  formSetCheckbox: (fieldName, model) ->
    value = if @_isModel(model) then model.get(fieldName) else model
    field = @$("##{fieldName}")
    
    if value == true
      field.attr('checked', true)
    else
      field.removeAttr('checked')    
        
  formGetCheckbox: (fieldName, model) ->
    field = @$("##{fieldName}")    
    value = field.is(':checked')

    if model?
      options = {}
      options[fieldName] = value  
      model.set(options, {silent: true})    
    return value

# MODEL OR VALUE
  _isModel: (model) ->
    model? && typeof(model) == 'object'
            
