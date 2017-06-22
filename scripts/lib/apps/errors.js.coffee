do ->
  _constructed = Bx.View.Base.prototype.constructed
  _removed = Bx.View.Base.prototype.removed

  _.extend Bx.View.Base.prototype,
  # BIND
    constructed:(options) ->
      _constructed(options) if _constructed?
      Bx.Pool.Model.get('alert').bind("change:fields", @bindAlertChange, @)

    removed: ->
      Bx.Pool.Model.get('alert').unbind("change:fields", @bindAlertChange, @)
      _removed() if _removed?

  # BIND
    bindAlertChange: ->
      @hideErrors()
      @showErrors()

  # RENDER
    hideErrors: ->
      @$('ul.parsley-error-list').remove()
      _.each @$('.form-control.parsley-error'), (field) ->
        $(field).removeClass('parsley-error')
        $(field).parent().find('.selectize-input').removeClass('parsley-error')

    showErrors: ->
      alert = Bx.Pool.Model.get('alert')
      _.each alert.get("fields"), (value, id) =>
        @showError(".form-control##{id}", value)

    showError: (fieldId, message) ->
      @$(fieldId).addClass("parsley-error")

      placeholder = @$(fieldId).attr('placeholder') ? ''
      $li = $('<li>').addClass('required').html("#{placeholder} #{message}")
      $ul = $('<ul>').addClass('parsley-error-list')

      $ul.append($li)
      @$(fieldId).parent().append($ul)
      @$(fieldId).parent().find('.selectize-input').addClass('parsley-error')
