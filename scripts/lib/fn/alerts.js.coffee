Apps.alertsInit = () ->
  alert = Bx.Pool.Model.get('alert')
  alert.bind 'change', ->
    if alert.has("importance") && alert.get("importance") != ""
      header = alert.get("header")
      unless header
        if alert.get("importance") == 'success'
          header = "Success"
        else if alert.get("importance") == 'error'
          header = "Error"
        else
          header = "Warning"

      Apps.alert(header, alert.get("message"), "growl-#{alert.get("importance")}")
      alert.unset("importance", {silent: true})

Apps.alert = (title, message, growlClass, timeout = 4000, onClose = null) ->
  $m = $('<div>')
  $m.addClass(growlClass)
  $m.append("<h1>#{title}</h1>") if title?
  $m.append("<h2>#{message}</h2>") if message?
  $m.bind('click', $.unblockUI);

  $.blockUI
    message: $m, fadeIn: 700, fadeOut: 2000, centerY: false, baseZ: 5000,
    timeout: timeout, showOverlay: false,
    onUnblock: onClose,
    css:
      width:    '370px',
      top:      '45px',
      left:     '',
      right:    '10px',
      border:   '2px solid #CCC',
      padding:  '5px',
      # opacity:  0.8,
      cursor:   'default',
      color:    '#fff',
      backgroundColor: '#FFF',
      '-webkit-border-radius': '10px',
      '-moz-border-radius':    '10px',
      'border-radius':         '10px'

Apps.alertError = (title, message, timeout = 4000, onClose = null) ->
  Apps.alert(title, message, "growl-error", timeout, onClose)

Apps.alertSuccess = (title, message, timeout = 4000, onClose = null) ->
  Apps.alert(title, message, "growl-success", timeout, onClose)

Apps.alertMessage = (title, message, timeout = 4000, onClose = null) ->
  Apps.alert(title, message, "growl-message", timeout, onClose)
