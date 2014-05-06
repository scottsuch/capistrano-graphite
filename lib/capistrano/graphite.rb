require 'capistrano'
require 'net/http'
require 'uri'

set :local_user, ENV['USER']

class GraphiteInterface
  def self.events_enabled
    if fetch(:graphite_enable_events).to_i == 1
      return 1
    elsif fetch(:graphite_enable_events).to_i == 0
      puts "Not sending an event: graphite_enable_events was set to 0."
      return 0
    else
      warn "Not sending an event: graphite_enable_events was assigned an "\
            "invalid value."
      return 0
    end
  end

  def self.post_event(action)
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
    if GraphiteInterface.events_enabled == 1
      action = "deploy"
      GraphiteInterface.post_event(action)
    end
  end

  desc 'notify graphite that a rollback occured'
  task :graphite_rollback do
    if GraphiteIntervace.events_enabled == 1
      action = "rollback"
      GraphiteInterface.post_event(action)
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
