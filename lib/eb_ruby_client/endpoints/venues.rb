require 'eb_ruby_client'

module EbRubyClient
  module Endpoints
    class Venues
      attr_reader :connection

      def initialize(connection:)
        @connection = connection
      end

      def create(venue)
        response = connection.post('venues/', venue.to_data)
        
        EbRubyClient::Resource::Venue.new(response)
      end
    end
  end
end