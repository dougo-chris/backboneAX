class Bx.Pool
  @fill: (datasets)->
    _.each datasets, (e) ->
      if e.dataset && e.dataset.model
        Bx.ModelPool.get(e.dataset.model).set(JSON.parse($(e).text()), {silent: true})
      else if e.dataset && e.dataset.collection
        Gec.CollectionPool.get(e.dataset.collection).reset(JSON.parse($(e).text()))
      else if e.dataset && e.dataset.array  
        data = Bx.ArrayPool.get(e.dataset.array)
        $.extend(data, JSON.parse($(e).text()))
      else if e.dataset && e.dataset.hash
        data = Bx.HashPool.get(e.dataset.hash)
        $.extend(data, JSON.parse($(e).text()))
