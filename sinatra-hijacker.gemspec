# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/hijacker/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatra-hijacker"
  spec.version       = Sinatra::Hijacker::VERSION
  spec.authors       = ["minoritea"]
  spec.email         = ["m.tokuda@aol.jp"]
  spec.description   = %q{A sinatra plugin to handle websockets by Rack hijacking API}
  spec.summary       = %q{Usage: register Sinatra::Hijacker and define route by "websocket" method}
  spec.homepage      = "https://github.com/minoritea/sinatra-hijacker"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  
  spec.add_dependency "rack", "~> 1.5"
  spec.add_dependency "tubesock"
end
