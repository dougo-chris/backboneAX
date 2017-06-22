class Bx.View.Base extends Backbone.View
  constructor: (options) ->
    super(options)
    # allow overriding of the "contructed" method
    @constructed(options) if @constructed?

  remove: () ->
    super()
    # allow overriding of the "removed" method
    @removed() if @removed?

  @include: (mixins...) ->
    throw new Error('include(mixins...) requires at least one mixin') unless mixins and mixins.length > 0

    for mixin in mixins
      for key, value of mixin
        @::[key] = value unless key is 'included'

      mixin.included?.apply(@)
    this

  # MODEL OR VALUE
  _isModel: (model) ->
    model? && typeof(model) == 'object'
