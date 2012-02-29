class Bx.Pool.Filler
  @fill: (datasets)->
    _.each datasets, (e) ->
      if e.dataset && e.dataset.model
        Bx.Pool.Model.get(e.dataset.model).set(JSON.parse($(e).text()))
      else if e.dataset && e.dataset.collection
        Bx.Pool.Collection.get(e.dataset.collection).reset(JSON.parse($(e).text()))
      else if e.dataset && e.dataset.array  
        data = Bx.Pool.Array.get(e.dataset.array)
        $.extend(data, JSON.parse($(e).text()))
      else if e.dataset && e.dataset.hash
        data = Bx.Pool.Hash.get(e.dataset.hash)
        $.extend(data, JSON.parse($(e).text()))
