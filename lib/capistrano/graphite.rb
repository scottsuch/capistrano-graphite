# encoding: utf-8

require 'capistrano'
require 'net/http'
require 'uri'
require 'sshkit'
require 'sshkit/dsl'

# Build the request to post
class GraphiteInterface
  def post_event(action)
    uri = URI.parse("#{fetch(:graphite_url)}")
    req = Net::HTTP::Post.new(uri.path)
    req.basic_auth(uri.user, uri.password) if uri.user
    req.body = event(action).to_json

    opts = { use_ssl: uri.scheme == 'https' }.merge(fetch(:graphite_http_options))

    Net::HTTP.start(uri.host, uri.port, opts) do |http|
      http.request(req)
    end
  end

  def event(action)
    {
      'what' => fetch(:graphite_event_msg).call(action),
      'tags' => fetch(:graphite_event_tags).call(action),
      'data' => fetch(:graphite_event_data)
    }
  end
end

namespace :deploy do
  desc 'Post an event to graphite'
  task :post_graphite, :action do |_, args|
    action = args[:action]
    run_locally do
      if fetch(:suppress_graphite_events).downcase == 'false'
        GraphiteInterface.new.post_event("#{action}")
        info("#{action.capitalize} event posted to graphite.")
      elsif fetch(:suppress_graphite_events).downcase == 'true'
        info('No event posted: `suppress_graphite_events` is set to true.')
      else
        warn('No event posted: `suppress_graphite_events` is set incorrectly.')
      end
    end
  end

  # Set the order for these tasks
  after 'deploy:finishing', 'post_graphite_deploy' do
    invoke('deploy:post_graphite', 'deploy')
  end
  after 'deploy:finishing_rollback', 'post_graphite_rollback' do
    invoke('deploy:post_graphite', 'rollback')
  end
end

namespace :load do
  task :defaults do
    set :suppress_graphite_events, 'false'
    set :graphite_event_user, ENV.fetch('USER', 'unknown')
    set :graphite_event_data, -> { fetch(:graphite_event_user) }
    set :graphite_event_tags, (lambda do |action|
      [fetch(:application), fetch(:stage), release_timestamp, action].join(',')
    end)
    set :graphite_event_msg, (lambda do |action|
      "#{action} #{fetch(:application)} in #{fetch(:stage)}"
    end)
    set :graphite_http_options, verify_mode: OpenSSL::SSL::VERIFY_PEER
  end
end
