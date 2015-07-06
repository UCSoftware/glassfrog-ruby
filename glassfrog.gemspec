# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'glassfrog/version'

Gem::Specification.new do |spec|
  spec.name          = "glassfrog"
  spec.version       = Glassfrog::VERSION
  spec.authors       = ["Undercurrent"]
  spec.email         = ["robert.wells@undercurrent.com"]

  spec.summary       = %q{A Ruby interface for the GlassFrog API.}
  spec.homepage      = "https://github.com/UCSoftware/glassfrog-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime Dependencies
  spec.add_runtime_dependency "addressable", "~> 2.3"
  spec.add_runtime_dependency "http", "~> 0.8.0"
  spec.add_runtime_dependency "rack-cache", "~> 1.2"

  # Development Dependencies
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
end
