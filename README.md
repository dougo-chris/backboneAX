# backboneAX - Backbone Application Extension

This is a set of backbone extensions that have help make my backbone projects easier to maintain. Hope it helps you too.

## Classes

### Bx.Model.Base

Extends the Backbone.Model class to let me know the connection state of the class

### Bx.Collection.Base

- Extends the Backbone.Collection class to let me know the connection state of the class.
- Supports fetchOnce which will not retry a fetch if one has already been called


### Bx.Collection.Paginate

- Pagination.

### Bx.View.Base

- Manages child view creation and releasing.
- Setting data from models to views of templates
- Setting and getting of form data

### Pooled data objects

- Bx.Pool.Hash
- Bx.Pool.Array
- Bx.Pool.Model
- Bx.Pool.Collection