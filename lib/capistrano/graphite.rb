require 'capistrano'
require 'net/http'
require 'uri'
require 'sshkit'
require 'sshkit/dsl'

set :local_user, ENV['USER']

class GraphiteInterface
  def self.events_enabled(action)
    if fetch(:graphite_enable_events).to_i == 1
      # We only post an event if graphite_enable_events was set to 1
      GraphiteInterface.new.post_event(action)
      return 1
    elsif fetch(:graphite_enable_events).to_i == 0
      return 0
    else
      return -1
    end
  end

  def post_event(action)
    uri = URI::parse("#{fetch(:graphite_url)}")
    req = Net::HTTP::Post.new(uri.path)
    req.basic_auth(uri.user, uri.password) if uri.user
    req.body = "{\"what\": \"#{action} #{fetch(:application)} in #{fetch(:stage)}\", \"tags\": \"#{fetch(:application)},#{fetch(:stage)},#{release_timestamp},#{action}\", \"data\": \"#{fetch(:local_user)}\"}"

    Net::HTTP.start(uri.host, uri.port) do |http|
      http.request(req)
    end
  end
end

namespace :deploy do
  desc 'notify graphite that a deployment occured'
  task :graphite_deploy do
    on roles(:all) do |host|
      action = "deploy"
      if GraphiteInterface.events_enabled(action) == 1
        info("#{action.capitalize} event posted to graphite.")
      elsif GraphiteInterface.events_enabled(action) == 0
        info("No event posted: graphite_enable_events set to 0.")
      else
        warn("No event posted: graphite_enable_events set to invalid variable.")
      end
    end
  end

  desc 'notify graphite that a rollback occured'
  task :graphite_rollback do
    on roles(:all) do |host|
      action = "rollback"
      if GraphiteInterface.events_enabled(action) == 1
        info("#{action.capitalize} event posted to graphite.")
      elsif GraphiteInterface.events_enabled(action) == 0
        info("No event posted: graphite_enable_events set to 0.")
      else
        warn("No event posted: graphite_enable_events set to invalid variable.")
      end
    end
  end

  # Set the order for these tasks
  after 'deploy:updated', 'deploy:graphite_deploy'
  after 'deploy:reverted', 'deploy:graphite_rollback'
end

namespace :load do
  task :defaults do
    set :graphite_enable_events, 1
  end
end
