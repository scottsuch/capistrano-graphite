require 'capistrano'
require 'net/http'
require 'uri'

set :local_user, ENV['USER']

class GraphiteInterface
  def self.post_event(action)
    uri = URI::parse("#{fetch(:graphite_url)}")
    Net::HTTP.start(uri.host, uri.port)  do |http|
      http.post(uri.path, "{\"what\": \"#{action} #{fetch(:application)} in #{fetch(:stage)}\", \"tags\": \"#{fetch(:application)},#{fetch(:stage)},#{release_timestamp},#{action}\", \"data\": \"#{fetch(:local_user)}\"}")
    end
  end
end

namespace :deploy do
  desc 'notify graphite that a deployment occured'
  task :graphite_deploy do
    if fetch(:graphite_enable_events).to_i == 1
      action = "deploy"
      GraphiteInterface.post_event(action)
    end
  end

  desc 'notify graphite that a rollback occured'
  task :graphite_rollback do
    if fetch(:graphite_enable_events).to_i == 1
      action = "rollback"
      GraphiteInterface.post_event(action)
    end
  end

  # Set the order for these tasks
  after 'deploy:updated', 'deploy:graphite_deploy'
  after 'deploy:reverted', 'deploy:graphite_rollback'
end
