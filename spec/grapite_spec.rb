# graphite_spec.rb
require 'spec_helper'
require 'capistrano/graphite.rb'

RSpec.describe GraphiteInterface do
  describe "#post_event" do
    context "deploy" do
      it 'posts a deploy event to graphite' do
        stub_request(:post, "http://localhost/").
        with(:body => "{\"what\": \"deploy testapp\", \"tags\": \"testapp,randomsha,deploy\", \"data\": \"testuser\"}").
        to_return(:status => 200, :body => "", :headers => {})
      end
    end
    context "rollback" do
      it 'posts a rollback event to graphite' do
        stub_request(:post, "http://localhost/").
        with(:body => "{\"what\": \"rollback testapp\", \"tags\": \"testapp,randomsha,deploy\", \"data\": \"testuser\"}").
        to_return(:status => 200, :body => "", :headers => {})
      end
    end
  end
end
