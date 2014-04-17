# Capistrano::Graphite
[![Code Climate](https://codeclimate.com/github/scottsuch/capistrano-graphite.png)](https://codeclimate.com/github/scottsuch/capistrano-graphite)
This gem extends capistrano's deploy functionality by pushing events to graphite
Some information on events can be found in [this nice writeup](http://obfuscurity.com/2014/01/Graphite-Tip-A-Better-Way-to-Store-Events).
This gem works with capistrano v3.1.0 and above.
For a gem that works with older versions of capistrano go [here](https://github.com/hellvinz/graphite-notify).

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-graphite'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-graphite

## Usage

Require in ```Capfile``` to use the default task:

    require "capistrano/graphite"

Configurable options:

    set :graphite_url, "http://example.com:8000/events/"

## Contributing

1. Fork it ( https://github.com/[my-github-username]/capistrano-graphite/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
