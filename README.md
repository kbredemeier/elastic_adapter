[![Build Status](https://travis-ci.org/kbredemeier/elastic_adatper.svg?branch=master)](https://travis-ci.org/kbredemeier/elastic_adatper) [![Code Climate](https://codeclimate.com/github/kbredemeier/elastic_adatper/badges/gpa.svg)](https://codeclimate.com/github/kbredemeier/elastic_adatper)

# ElasticAdapter

This gem provides an implementation of the repository pattern. It is a result of some frustration
I had with the [elasticsearch-persistence](https://github.com/elasticsearch/elasticsearch-rails/tree/master/elasticsearch-persistence) gem. After reading [Hashie Considered Harmful](http://www.schneems.com/2014/12/15/hashie-considered-harmful.html) and some issues
I had with overriding methods on a subclassed Repository I decided to give it a own try.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'elastic_adapter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elastic_adapter

## Documentation

Documentation can be found [here](http://www.rubydoc.info/github/kbredemeier/elastic_adatper/)

## Usage

First define the document type. Initialize it by passing a `name` and some `mappings` to the constructor:

```ruby
mappings = {
  product: {
    properties: {
      name: {
        type: "string",
        index_analyzer: "simple",
        search_analyzer: "simple"
      },
      name_suggest: {
        type: "completion"
      },
      price: {
        type: "float",
        index: "not_analyzed"
      }
    }
  }
}

document_type = ElasticAdapter::DocumentType.new("product", mappings)
```

Next define the index settings and instantiate the index:

```ruby
settings = { number_of_shards: 1 }


index = ElasticAdapter::Index.new(
  name: "product_index",
  url: "http://localhost:9200",
  log: true,
  settings: settings,
  document_type: document_type
)
```

Now you can perform actions like create the index, index documents or search for them.
For a full list of feaures look into the [Documentation](http://www.rubydoc.info/github/kbredemeier/elastic_adatper/master/ElasticAdapter/Index).

```ruby
# Creating an Index

response = index.create_index
response.inspect # => "{:acknowledged=>true}"
response.class # => ElasticAdapter::Response
response.success? # => true

# Add a document to the index

doc = {
  id: 1,
  name_name: "foo",
  suggest: "foo",
  price: 11.12
}

response = index.index(doc)
response.inspect # => "{:index=>\"product_index\", :type=>\"product\", :id=>\"1\", :version=>1, :created=>true}"
response.class # => ElasticAdapter::Response
response.success? # => true

# Search for documents

query = {query: {match: {name: "foo"}}}
response = index.search(query)
response.inspect # => "{:count=>1, :hits=>[{:id=>\"1\", :name=>\"foo\", :name_suggest=>\"foo\", :price=>11.12}]}"
response.class # => ElasticAdapter::Decoration::SearchResponse
```

Fore more usage examples look [here](https://github.com/kbredemeier/elastic_adatper/tree/master/examples)

## Testing and Development

I am using [VCR](https://github.com/vcr/vcr) to record the requests to elasticsearch and play them back while testing.
In some cases it might be necessary to rerecord the requests. Because elasticsearch is a little slow and doesn't return documents for a
search request that just have been indexed there are some sleep statements in the spec. To not slow down the tests those sleep statements
are just executed if a `RECORDING` environment variable is set. I added a rake task that sets the environment variable deletes the cassetts
and runs all specs with `:vcr`. Run `rake record` to rerecord the cassettes.

## Contributing

1. Fork it ( https://github.com/kbredemeier/elastic_adapter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
