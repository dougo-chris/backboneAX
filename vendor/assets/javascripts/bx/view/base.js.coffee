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
