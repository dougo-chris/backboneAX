$.fn.blockit = ->
  if !@attr('data-blockit')? || @attr('data-blockit') == ''
    @attr('data-blockit', 'on')
    @block {
        message: '<div class="blockit-loading"><h1><i class="fa fa-spinner fa-spin"></i></h1></div>'
        css:
          width: '60px'
          height: '60px'
          backgroundColor: 'transparent'
          border: '0px solid #ccc'
        overlayCSS:
          opacity: '0.50'
          border: '3px solid #111'
      }
  return this

$.fn.unblockit = ->
  @attr('data-blockit', '')
  @unblock()
  return this

$.fn.flashit = (message)->
  if !@attr('data-flashit')? || @attr('data-flashit') == ''
    @attr('data-flashit', 'on')
    @block {
        message: "<div class='flashit-loading'><h1>#{message}</i></h1></div>"
        css:
          width: '60px'
          height: '60px'
          backgroundColor: 'transparent'
          border: '0px solid #ccc'
        overlayCSS:
          backgroundColor: '#fee188'
          opacity: '0.50'
          border: '3px solid #f7d05b'
      }
  return this

$.fn.unflashit = ->
  @attr('data-flashit', '')
  @unblock()
  return this