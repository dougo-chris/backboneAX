#= require_self
#= require_tree ./bx

window.Bx =
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
      Bx.Model.Pool.get('alert').set
        importance: "error"
        header: "Login Required"
        message: error  ?  "Invalid Login Details"
        fields: {
          email: ""
          password: ""
        }
      window.router.navigate('/login', true)
      
    else if (response.status == 403)
      errorResponse = $.parseJSON(response.responseText)
      error = errorResponse.error
      Bx.Model.Pool.get('alert').set
        importance: "error"
        header: "Access Denied"
        message: error ?  ""
        fields: {
          email: ""
          password: ""
        }
      window.router.navigate('/', true)

    else if (response.status == 404)
      Bx.Model.Pool.get('alert').set
        importance: "error"
        header: "Server Error"
      # document.write(response.responseText)

    else if (response.status == 302)
      redirectResponse = $.parseJSON(response.responseText)
      window.router.navigate(redirectResponse.redirect, true)

    else if (response.status != 500)
      error = $.parseJSON(response.responseText)
      Bx.Model.Pool.get('alert').set(error)

    else if (response.status == 500)
      document.write(response.responseText)
