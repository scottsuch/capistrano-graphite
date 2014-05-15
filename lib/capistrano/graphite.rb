require 'capistrano'
require 'net/http'
require 'uri'
require 'sshkit'
require 'sshkit/dsl'

class GraphiteInterface
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
  desc 'Post an event to graphite'
  task :post_graphite, :action do |t, args|
    action = args[:action]
    on roles(:all) do |host|
      if fetch(:suppress_graphite_events).downcase == "true"
        GraphiteInterface.new.post_event("#{action}")
        info("#{action.capitalize} event posted to graphite.")
      elsif fetch(:suppress_graphite_events).downcase == "false"
        info("No event posted: `suppress_graphite_events` set to true.")
      else
        warn("No event posted: `suppress_graphite_events` set incorrectly.")
      end
    end
  end

  # Set the order for these tasks
  after 'deploy:updated', 'post_graphite_deploy' do
    Rake::Task['deploy:post_graphite'].invoke 'deploy'
  end
  after 'deploy:reverted', 'post_graphite_rollback' do
    Rake::Task['deploy:post_graphite'].invoke 'rollback'
  end
end

namespace :load do
  task :defaults do
    set :suppress_graphite_events, "false"
    set :local_user, ENV['USER']
  end
end
