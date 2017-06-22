_.extend Bx.View.Base.prototype,
  modalInit: () ->
    @_modalInit = true
    @_modalView = undefined
    @_modalDelay = undefined

  modalVisible: ->
    @_modalView?

  modalDestroy: (noDelay = false) ->
    console?.log?('modalInit Required') unless @_modalInit == true

    return unless @_modalView?
    tempView = @_modalView
    @_modalView = undefined
    @$('#modalBox').modal('hide')
    tempView.remove()

    if @_modalDelay == true && noDelay != true
      delayed = () =>
        Apps.unblocker()

      Apps.blocker()
      setTimeout(delayed, 250)

  modalShow: (modalView, options = {}) ->
    console?.log?('modalInit Required') unless @_modalInit == true

    @modalDestroy(true)

    @_modalDelay = options.delay

    @_modalView = modalView
    $modalBox = @$('#modalBox')
    if $modalBox.length == 0
      $modalBox = $('<div>').addClass('modal').attr('id', 'modalBox')
      $modalDialog = $('<div>').addClass('modal-dialog').addClass('modal-dialog-center')
      $modalBox.append($modalDialog)
      $modalContent = $('<div>').addClass('modal-content').attr('id', 'modalBoxContent')
      $modalDialog.append($modalContent)
      $(@el).append($modalBox)

    width = options.width ? '480px'
    $modalBox.find('.modal-dialog').attr('style', "width:#{width};")

    modal = $modalBox.modal({backdrop: true, show: true, keyboard: true})
    $(modal).find('#modalBoxContent').html(@_modalView.render().el)

    marginTop = ->
      if $(window).height() < $(this).outerHeight() * 2
        magnitude = 0.5
      else if $(window).height() > $(this).outerHeight() * 4
        magnitude = 1.0
      else
        magnitude = 0.75

      -($(this).outerHeight() * magnitude)

    marginLeft = ->
      -($(this).outerWidth() / 2)

    $(modal).find('.modal-dialog').css({'margin-top': marginTop, 'margin-left': marginLeft})

    Apps.attached()