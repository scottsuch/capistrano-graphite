# encoding: utf-8

require 'rspec'
require 'rake'
require 'webmock/rspec'
require 'capistrano/all'
require 'capistrano/framework'
require 'capistrano/setup'
require 'tempfile'

require 'coveralls'
Coveralls.wear!
