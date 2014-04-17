# Capistrano::Graphite
[![Gem Version](http://img.shields.io/gem/v/capistrano-graphite.svg)][gem]
[![Dependency Status](http://img.shields.io/gemnasium/scottsuch/capistrano-graphite.svg)][gemnasium]
[![Build Status](http://img.shields.io/travis/scottsuch/capistrano-graphite.svg)][travis]
[![Code Climate](http://img.shields.io/codeclimate/github/scottsuch/capistrano-graphite.svg)][codeclimate]

[gem]: https://rubygems.org/gems/capistrano-graphite
[gemnasium]: https://gemnasium.com/scottsuch/capistrano-graphite
[travis]: http://travis-ci.org/scottsuch/capistrano-graphite
[codeclimate]: https://codeclimate.com/github/scottsuch/capistrano-graphite
This gem extends [Capistrano's](https://github.com/capistrano/capistrano) deploy functionality by pushing events to graphite.
Currently events are only pushed after ```deploy:updated``` and ```deploy:reverted```.
Some information on events can be found in [this nice writeup](http://obfuscurity.com/2014/01/Graphite-Tip-A-Better-Way-to-Store-Events).
This gem works with Capistrano v3.1.0 and above.
For a gem that works with older versions of Capistrano look [here](https://github.com/hellvinz/graphite-notify).

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-graphite'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-graphite

## Usage

Require in ```Capfile``` to use the default tasks:

    require "capistrano/graphite"

Configurable options

    set :graphite_url, "http://example.com:8000/events/"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
