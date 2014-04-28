# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/graphite/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-graphite"
  spec.version       = Capistrano::Graphite::VERSION
  spec.authors       = ["scottsuch"]
  spec.email         = ["sgorsuch@gmail.com"]
  spec.summary       = %q{A gem for pushing graphite events via capistrano v3
                          deployment}
  spec.description   = %q{This gem plugs into the deploy task in capistrano to
                          help provide visibility into when deployments and
                          rollbacks occured.}
  spec.homepage      = "https://github.com/scottsuch/capistrano-graphite"
  spec.license       = "MIT"

  spec.required_ruby_version = '> 1.9'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
