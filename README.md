# Crolia

Crolia is a wrapper around [Algolia.com's](http://algolia.com) api allowing you to use most of their REST api features from inserting/deleting/updating and searching data.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  Crolia:
    github: exts/Crolia
```

## Usage

### Connecting to api

```crystal
require "Crolia"

api = Crolia::Api.new "API_KEY", "API_ID"
```

###### Search Index by keyword
```crystal
index = api.index "example_index"
results = index.find_by "example_search_term"
puts results.data # returns algolia response message/results
```

###### Search multiple indices by keywords
```crystal
index = api.index "example_index"
results = index.find_multiple([
    {"params" => "query=data"}
])
puts results.data # returns algolia response message/results
```

###### List all Indexes
```crystal
index = api.index "example_index"
results = index.find_all
puts results.data
```

###### Find object by id
```crystal
object = api.objects "example_index"
results = object.find("1") # you can pass attributes as the 2nd parameter using a Hash(String, String)
puts results.data
```

###### Find multiple objects
```crystal
object = api.objects "example_index"
results = object.find_all([
    {"objectID" => "1"},
    {"objectID" => "2"},
])
puts results.data
```

###### Insert or Update an object
```crystal
object = api.objects "example_index"

# first paramter just pass a has and convert it to json using .to_json, 2nd parameter is optional it's he id, if you leave it blank it'll create an objectId for you
results = object.add_or_update({"title" => "Custom Title", "tags" => ["custom_tag_1", "custom_tag_2"]}.to_json, "3")
puts results.data
```

###### Partial Update an object
```crystal
object = api.objects "example_index"

# first parameter is the id you want to pass, 2nd parameter is the data you want to partially update (convert to json) 
# and the last field that's optional is a boolean which forces the creating of the object if it doesn't exist, disabled by default
object.partial_update("5", {"title" => "Updated Title", "shouldnt_get_created" => true}.to_json)
puts results.data
```

###### Delete an object
```crystal
object = api.objects "example_index"

# as simple as passing the object id to be deleted
objects.delete("4")

puts results.data
```


## TODO
- Batch write operations
- Batch write operations (multiple indices)
- Browse all index content
- Browse all index content (alternative)
- Get index settings
- Change index settings
- Copy/move an index
- Get a task’s status
- Add an index-specific API key
- Update an index-specific API key
- List index-specific API keys
- List index-specific API keys (for all indices)
- Retrieve an index-specific API key
- Delete an index-specific API key
- Search for facet values

## Contributors

- [[exts]](https://github.com/exts) exts - creator, maintainer
