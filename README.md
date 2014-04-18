# Capistrano::Graphite
[![Gem Version](http://img.shields.io/gem/v/capistrano-graphite.svg)][gem]
[![Dependency Status](http://img.shields.io/gemnasium/scottsuch/capistrano-graphite.svg)][gemnasium]
[![Build Status](http://img.shields.io/travis/scottsuch/capistrano-graphite.svg)][travis]
[![Code Climate](http://img.shields.io/codeclimate/github/scottsuch/capistrano-graphite.svg)][codeclimate]

[gem]: https://rubygems.org/gems/capistrano-graphite
[gemnasium]: https://gemnasium.com/scottsuch/capistrano-graphite
[travis]: http://travis-ci.org/scottsuch/capistrano-graphite
[codeclimate]: https://codeclimate.com/github/scottsuch/capistrano-graphite
This gem works with Capistrano v3.1.0 and above and was based off the work on [this gem](https://github.com/hellvinz/graphite-notify) which works with Capistrano v2.x.

Adding this gem to [Capistrano](https://github.com/capistrano/capistrano) deploy extends functionality by pushing events to graphite.
Currently events are only pushed after ```deploy:updated``` and ```deploy:reverted```.

Some information on events can be found in [this article](http://obfuscurity.com/2014/01/Graphite-Tip-A-Better-Way-to-Store-Events).

## Installation
Install it manually:

    $ gem install capistrano-graphite

Otherwise, add this line to your application's Gemfile:

    gem 'capistrano-graphite'

And then execute:

    $ bundle

## Usage
### Setup your application
Add the following line to your ```Capfile```.

    require "capistrano/graphite"

### Configurable options
Path to your graphite instance

    set :graphite_url, "http://example.com:8000/events/"  # The port distinction is optional

Disable sending events for a particular stage by setting the following to 0

    set :graphite_enable_events, 0                        # This is set to 1 by default

### Test that it's working
You can run the following on it's own assuming you have configured the graphite url

    $ bundle exec cap <stage> deploy:graphite_deploy

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
