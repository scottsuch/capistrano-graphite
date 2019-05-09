# Capistrano::Graphite
[![Gem Version](http://img.shields.io/gem/v/capistrano-graphite.svg)](https://rubygems.org/gems/capistrano-graphite)
[![Build Status](http://img.shields.io/travis/scottsuch/capistrano-graphite.svg)](http://travis-ci.org/scottsuch/capistrano-graphite)
[![Maintainability](https://img.shields.io/codeclimate/maintainability/scottsuch/capistrano-graphite.svg)](https://codeclimate.com/github/scottsuch/capistrano-graphite/maintainability)
[![Coverage Status](https://img.shields.io/coveralls/scottsuch/capistrano-graphite.svg)](https://coveralls.io/r/scottsuch/capistrano-graphite?branch=master)

This gem works with Capistrano v3.0.0 and above and was based off the work on [this gem](https://github.com/hellvinz/graphite-notify) which works with Capistrano v2.x.

Adding this gem to [Capistrano](https://github.com/capistrano/capistrano) extends functionality by pushing events to graphite upon deployment and rollback.
Currently events are only pushed after `deploy:updated` and `deploy:reverted`.

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
Add the following line to your `Capfile`.

    require "capistrano/graphite"

### Configurable options
Path to your graphite instance. Port and user:password are optional.

    set :graphite_url, "http://user:password@example.com:8000/events/"

Disable sending events for a particular stage by setting the following:

    set :suppress_graphite_events, "true"      # This is set to false by default

Note that the config `graphite_enable_events` was deprecated in version 1.0.0.

Optionally, override the rest of graphite settings:

    set :graphite_event_user, ENV.fetch('USER', 'unknown')
    set :graphite_event_data, -> { fetch(:graphite_event_user) }
    set :graphite_event_tags, -> (action) do
      [fetch(:application), fetch(:stage), release_timestamp, action].join(',')
    end
    set :graphite_event_msg, -> (action) do
      "#{action} #{fetch(:application)} in #{fetch(:stage)}"
    end

### Test that it's working
You can run the following on it's own assuming you have configured the graphite url

    $ bundle exec cap <stage> deploy:post_graphite['deploy']

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
