# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elastic_adapter/version'

Gem::Specification.new do |spec|
  spec.name          = "elastic_adapter"
  spec.version       = ElasticAdapter::VERSION
  spec.authors       = ["Kristopher Bredemeier"]
  spec.email         = ["k.bredemeier@gmail.com"]
  spec.summary       = %q{Repository like access to elasticseach indices}
  spec.description   = %q{Repository like access to elasticseach indices}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "elasticsearch", "~> 1.0.6"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "vcr", "~> 2.9.3"
  spec.add_development_dependency "webmock", "~> 1.20.4"
  spec.add_development_dependency "pry-byebug", "~> 3.0.1"
  spec.add_development_dependency "yard", "~> 0.8.7.6"
end
