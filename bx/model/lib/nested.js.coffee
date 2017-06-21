do ->
  _parse = Bx.Model.Base.prototype.parse

  _.extend Bx.Model.Base.prototype,
    nestedModels: (models) ->
      @_nestedModels = {}
      _.each models, (theClass, key) =>
        @_nestedModels[key] = new theClass(@attributes[key] || {})
        @_nestedModels[key]['parent'] = @

    nestedCollections: (collections) ->
      @_nestedCollections = {}
      _.each collections, (theClass, key) =>
        options = {}
        options["#{key}Id"] = @attributes['id']
        @_nestedCollections[key] = new theClass([], options)
        @_nestedCollections[key]['parent'] = @
        models = _.map @attributes[key] || [], (modelAttr) =>
          model = new @_nestedCollections[key].model(modelAttr, {collection: @_nestedCollections[key]})
          model['parent'] = @
          model
        @_nestedCollections[key].set(models)

    parse: (resp, xhr) ->
      attributes = _parse(resp, xhr)
      if @_nestedModels?
        _.each @_nestedModels, (model, key) =>
          model.clear({silent: true})
          model.set(model.parse(attributes[key] || {}))
      if @_nestedCollections?
        _.each @_nestedCollections, (collection, key) =>
          models = _.map attributes[key] || [], (modelAttr) =>
            model = new collection.model(modelAttr, {collection: collection})
            model['parent'] = @
            model
          collection.reset(models)

      attributes

    getNestedModel: (name) ->
      @_nestedModels?[name]

    getNestedCollection: (name) ->
      @_nestedCollections?[name]

    # SET DEEP VALUES
    getNestedValue: (attr) ->
      fields = attr.split("-");
      value = @get(_.first(fields))
      _.each fields, (field, index) ->
        if index != 0
          value = value?[field]
      value

    setNestedValue: (attr, value) ->
      options = {}

      fields = attr.split("-");
      if _.size(fields) == 1
        options[attr] = value
      else
        data = @get(_.first(fields)) ? {}
        current = data
        _.each fields, (field, index) ->
          if index == 0
            # ignore
          else if index < _.size(fields) - 1
            current[field] ?= {}
            current = current[field]
          else
            current[field] = value
            current = current[field]

        options[_.first(fields)] = data

      @set(options, {silent: true})
