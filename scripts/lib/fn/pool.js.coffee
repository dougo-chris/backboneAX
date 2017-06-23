Apps.poolsInit = () ->
  _.each $('.jsonData'), (jsonData) ->
    datasets= $(jsonData).find('div')
    if datasets
      _.each datasets, (e) ->
        $e = $(e)
        if $e.attr('data-model')?
          Bx.Pool.Model.get($e.attr('data-model')).set(JSON.parse($e.text()))
        else if $e.attr('data-collection')?
          Bx.Pool.Collection.get($e.attr('data-collection')).reset(JSON.parse($e.text()))
        else if $e.attr('data-array')?
          data = Bx.Pool.Array.get($e.attr('data-array'))
          $.extend(data, JSON.parse($e.text()))
        else if $e.attr('data-hash')?
          data = Bx.Pool.Hash.get($e.attr('data-hash'))
          $.extend(data, JSON.parse($e.text()))