require 'eb_ruby_client/support/resource'

module EbRubyClient
  module Resource
    class Organizer
      include EbRubyClient::Support::Resource

      attr_accessor :description, :logo, :name, :id, :num_past_events, :num_future_events, :resource_uri, :url

      def initialize(data)
        set_attributes(data)
      end
    end
  end
end
