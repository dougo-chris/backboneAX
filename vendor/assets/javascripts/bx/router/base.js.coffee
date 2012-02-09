class Bx.Router.Base extends Backbone.Router

  navigate: (path, triggerRoutes) ->
    if !path? || path.length == 0 
      path = $.cookie("redirect")
  
     if !path? || path.length == 0 
       path = '/' 
    
    super(path, triggerRoutes)

  setRedirect: (path) ->
    $.cookie("redirect", path, 1)  

  resetRedirect: () ->
    $.cookie("redirect", "")     
