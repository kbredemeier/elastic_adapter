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

For a few specs I needed to place some sleep statements to make them work. To not slow down the specs with the sleep statements and for other reasons
I decided to use VCR to capture the requests. I added a rake taks which sets an environment variable which is used in a helper function to decide either to
`sleep 1` or not. This way the specs are not slowed down. To execute the rake task run `rake record`.

Unfortunatly VCR skips recording some context blocks for unknown reason. I didn't had the time to look into that yet. That means that it is required
to have a running elasticsearch at `localhost:9200` to run the specs.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/elastic_adapter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
