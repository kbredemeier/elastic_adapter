# ElasticAdapter

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'elastic_adapter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elastic_adapter

## Usage

TODO: Write usage instructions here


## Testing and Development

Some specs require an running Elasticsearch cluster. By default the spec expects the command `elasticsearch` to be exposed to thr user and executeable.
To specify the path to the Elasticsearch command the port and a few other things copy the `example.env` to `.env` and change it to your needs.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/elastic_adapter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
