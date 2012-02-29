#= require_self
#= require_tree ./bx

window.Bx =
  Pool: {}
  Model: {}
  Collection: {}
  Router: {}
  View: {}

Bx.manageErrors = () ->  
  $(document).ajaxError (event, response) ->
    if (response.status == 200)       
      # ignore it
    else if (response.status == 401)       
      errorResponse = $.parseJSON(response.responseText)
      error = errorResponse.error
      Bx.Pool.Model.get('alert').set
        importance: "error"
        header: "Login Required"
        message: error  ?  "Invalid Login Details"
        fields: {
          email: ""
          password: ""
        }
      window.router.navigate('BX_LOGIN_REQUIRED', true)
      
    else if (response.status == 403)
      errorResponse = $.parseJSON(response.responseText)
      error = errorResponse.error
      Bx.Pool.Model.get('alert').set
        importance: "error"
        header: "Access Denied"
        message: error ?  ""
        fields: {
          email: ""
          password: ""
        }
      window.router.navigate('BX_ACCESS_DENIED', true)

    else if (response.status == 404)
      Bx.Pool.Model.get('alert').set
        importance: "error"
        header: "Server Error"
      # document.write(response.responseText)

    else if (response.status == 302)
      redirectResponse = $.parseJSON(response.responseText)
      window.router.navigate(redirectResponse.redirect, true)

    else if (response.status != 500)
      error = $.parseJSON(response.responseText)
      Bx.Pool.Model.get('alert').set(error)

    else if (response.status == 500)
      document.write(response.responseText)
