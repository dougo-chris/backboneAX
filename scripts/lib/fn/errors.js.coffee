Apps.errorsInit = () ->
  $(document).ajaxError (event, response) -> Apps.error(response)
  $(document).ajaxSuccess (event, response) -> Apps.success(response)

Apps.success = (response) ->
  if (response.status == 200 || response.status == 0) # :ok
    # ignore it
  else if (response.status == 202)  # :accepted
    Bx.Pool.Model.get('alert').clear({silent: true})
    Bx.Pool.Model.get('alert').set($.parseJSON(response.responseText))

Apps.error = (response) ->
  if (response.status == 200 || response.status == 0) # :ok
    # ignore it
  else if (response.status == 401)   # :unauthorized
    Apps.setError("Login Required", "Invalid Login Details")
    window.router?.navigate('BX_LOGIN_REQUIRED', true)
  else if (response.status == 403) # :forbidden
    Apps.setError("Access Denied", "Access Denied")
    window.router?.navigate('BX_ACCESS_DENIED', true)
  else if (response.status == 404) # :not_found
    Apps.setError("Server Error", "Page not found")
  else if (response.status == 301) # :moved_permanently
    redirectResponse = $.parseJSON(response.responseText)
    window.location.href = redirectResponse.redirect
  else if (response.status == 302) # :found
    Apps.setMessage("Record not found", "Invalid record requested")
    redirectResponse = $.parseJSON(response.responseText)
    window.router?.navigate(redirectResponse.redirect, true)
  else if (response.status == 500) # :internal_server_error
    # document.write(response.responseText)
    window.router?.navigate('BX_ERROR', true)
  else if (response.status == 503) # :application_not_found (pow)
    document.write(response.responseText)
    window.router?.navigate('BX_ERROR', true)
  else  # should be an error
    Bx.Pool.Model.get('alert').clear({silent: true})
    Bx.Pool.Model.get('alert').set($.parseJSON(response.responseText))

Apps.resetError = () ->
  Bx.Pool.Model.get('alert').unset("importance", {silent: true})
  Bx.Pool.Model.get('alert').unset("fields", {silent: true})

Apps.setError = (header, message) ->
  Bx.Pool.Model.get('alert').set({importance: 'error', header: header, message: message})

Apps.setSuccess = (header, message) ->
  Bx.Pool.Model.get('alert').set({importance: 'success', header: header, message: message})

Apps.setMessage = (header, message) ->
  Bx.Pool.Model.get('alert').set({importance: 'message', header: header, message: message})
