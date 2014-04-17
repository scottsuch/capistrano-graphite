require 'capistrano'
require 'net/http'
require 'uri'

set :local_user, ENV['USER']

namespace :deploy do
  desc 'notify graphite that a deployment occured'
  task :graphite_deploy do
    uri = URI::parse("#{fetch(:graphite_url)}")
    Net::HTTP.start(uri.host, uri.port)  do |http|
      http.post(uri.path, "{\"what\": \"deploy #{fetch(:application)} in #{fetch(:stage)}\", \"tags\": \"#{fetch(:application)},#{fetch(:stage)},#{release_timestamp},deploy\", \"data\": \"#{fetch(:local_user)}\"}")
    end
  end

  desc 'notify graphite that a rollback occured'
  task :graphite_rollback do
    uri = URI::parse("#{fetch(:graphite_url)}")
    Net::HTTP.start(uri.host, uri.port)  do |http|
      http.post(uri.path, "{\"what\": \"rollback #{fetch(:application)} in #{fetch(:stage)}\", \"tags\": \"#{fetch(:application)},#{fetch(:stage)},#{release_timestamp},rollback\", \"data\": \"#{fetch(:local_user)}\"}")
    end
  end

  # Set the order for these tasks
  after 'deploy:updated', 'deploy:graphite_deploy'
  after 'deploy:reverted', 'deploy:graphite_rollback'
end
