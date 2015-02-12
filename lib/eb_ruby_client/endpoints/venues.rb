require 'eb_ruby_client/resource/venue'

module EbRubyClient
  module Endpoints
    class Venues
      attr_reader :connection

      def initialize(connection:)
        @connection = connection
      end

      def create(venue_data)
        response = connection.post('venues/', venue_data)

        EbRubyClient::Resource::Venue.new(response)
      end
    end
  end
end
