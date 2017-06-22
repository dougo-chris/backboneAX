Apps.blocker = ->
  $core = $('.blockable:first')
  if !$core.attr('data-blocker')? || $core.attr('data-blocker') == ''
    $core.attr('data-blocker', 'on')
    $.blockUI {
      message: '<div class="block-loading"><h1><i class="fa fa-spinner fa-spin"></i></h1></div>'
      css:
        width: '60px'
        height: '60px'
        backgroundColor: 'transparent'
        border: '0px solid #ccc'
      overlayCSS:
        opacity: '0.70'
    }

Apps.unblocker = ->
  $core = $('.blockable:first')
  $core.attr('data-blocker', '')
  $.unblockUI()
