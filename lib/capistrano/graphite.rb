require 'net/http'
require 'capistrano'
require 'uri'

local_user = ENV['USER'] || ENV['USERNAME']

namespace :deploy do
  desc 'notify graphite that a deployment occured'
  task :publish_event do
    uri = URI::parse("#{fetch(:graphite_url)}")
    Net::HTTP.start(uri.host, uri.port)  do |http|
      if respond_to?(:stage)
        http.post(uri.path, "{\"what\": \"deploy #{fetch(:application)} in #{fetch(:stage)}\", \"tags\": \"#{fetch(:application)},#{stage},#{release_timestamp},deploy\", \"data\": \"#{fetch(:local_user)}\"}")
      else
        http.post(uri.path, "{\"what\": \"deploy #{fetch(:application)}\", \"tags\": \"#{fetch(:application)},#{release_timestamp},deploy\", \"data\": \"#{fetch(:local_user)}\"}")
      end
    end
  end
end
