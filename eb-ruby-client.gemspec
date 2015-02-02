# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eb/ruby/client/version'

Gem::Specification.new do |spec|
  spec.name          = "eb-ruby-client"
  spec.version       = Eb::Ruby::Client::VERSION
  spec.authors       = ["Wool and the Gang", "John Cinnamond"]
  spec.email         = ["tech@woolandthegang.com"]
  spec.summary       = %q{An Eventbrite API client.}
  spec.homepage      = "https://github.com/watg/eb-ruby-client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
