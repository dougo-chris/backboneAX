class Bx.Collection.Paginate extends Bx.Collection.Base

  constructor: (models, options = {}) ->
    super(models, options)
    @pageSize = options.pageSize ? 10
    @pageCurrent = options.pageCurrent ? 0
    @pageTotal = options.pageTotal ? 1
    @current = options.current ? null

  parse: (response) ->
    @pageCurrent = if response.pagination then response.pagination.current ? 1 else 1
    @pageTotal = if response.pagination then response.pagination.total ? 1 else 1
    response.items || []

  fetch: (options = {}) ->
    options.data =  $.extend(options.data || {}, {page: @pageCurrent, pageSize: @pageSize})

    if @current? && @current.isNew()
      optionsSuccess = options.success
      options.success = (collection, response) =>
        first = collection.first()
        @currentSet(first.id) if first?
        optionsSuccess(collection, response) if optionsSuccess

    super(options)

# RESTART THE SEARCH
   restart: (options = {}) ->
    options.add = false
    @pageCurrent = 1
    @fetch(options)

# PREV PAGE / NEXT PAGE
  prev: (options = {}) ->
    if @pageCurrent > 0
      @pageCurrent--
      @fetch(options)

  hasPrev: () ->
    @pageCurrent > 1

  next: (options = {}) ->
    if @pageCurrent < @pageTotal
      @pageCurrent++
      @fetch(options)

  hasNext: () ->
    @pageCurrent < @pageTotal

# MORE PAGE
  more: (options = {}) ->
    options.add = true
    if @pageCurrent < @pageTotal
      @pageCurrent++
      @fetch(options)

  hasMore: () ->
    @pageCurrent < @pageTotal

# CURRENT
  currentSet: (id)->
    if @current? && @current.id != parseInt(id, 10)
      @current.set({id: id}, {silent: true})
      @current.fetch();

  currentPrev: () ->
    return unless @current?
    index = @indexOf(@current.id)
    if index > 0
      @currentSet(@at(index - 1).id)

  hasCurrentPrev: () ->
    return false unless @current?
    index = @indexOf(@current.id)
    return index > 0

  currentNext: () ->
    return unless @current?
    index = @indexOf(@current.id)
    if index < @size - 1
      @currentSet(@at(index + 1).id)
    else
      @more()

  hasCurrentNext: () ->
    return false unless @current?
    index = @indexOf(@current.id)
    return (index < @size - 1) || @hasMore()

