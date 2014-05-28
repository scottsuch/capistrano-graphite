# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/graphite/version'

Gem::Specification.new do |s|
  s.name          = "capistrano-graphite"
  s.version       = Capistrano::Graphite::VERSION
  s.authors       = ["scottsuch"]
  s.email         = ["sgorsuch@gmail.com"]
  s.summary       = "A gem for pushing graphite events via capistrano v3 " \
                    "deployment'"
  s.description   = "This gem plugs into the deploy task in capistrano to " \
                    "help provide visibility into when deployments and " \
                    "rollbacks occured."
  s.homepage      = "https://github.com/scottsuch/capistrano-graphite"
  s.license       = "MIT"

  s.required_ruby_version = '> 1.9'

  s.post_install_message = "The config `graphite_enable_events` has changed " \
                           "to `suppress_graphite_events` and will accept " \
                           "a true or false. See the README.md at" \
                           "https://github.com/scottsuch/capistrano-graphite " \
                           "for details.}"\

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency             "capistrano", "~> 3.0"
  s.add_development_dependency "bundler",    "~> 1.3"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "webmock"
  s.add_development_dependency "coveralls"
end
