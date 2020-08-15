# frozen_string_literal: true
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'termichunk/version'

Gem::Specification.new do |spec|
  spec.name          = "termichunk"
  spec.version       = TermiChunk::VERSION
  spec.authors       = ["Kevin McDonald"]
  spec.email         = ["kevinstuffandthings@gmail.com"]
  spec.summary       = %q{Organize chunks of text within terminals}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/kevinstuffandthings/termichunk"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
