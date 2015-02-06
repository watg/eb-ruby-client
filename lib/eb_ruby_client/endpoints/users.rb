require 'eb_ruby_client/resource/user'
require 'eb_ruby_client/resource/organizer'

module EbRubyClient
  module Endpoints
    class Users
      attr_reader :connection

      def initialize(connection:)
        @connection = connection
      end

      def me
        EbRubyClient::Resource::User.new(connection.get("users/me"))
      end

      def organizers(user_id:)
        connection.get("users/#{user_id}/organizers")["organizers"].map do |organizer_data|
          EbRubyClient::Resource::Organizer.new(organizer_data)
        end
      end
    end
  end
end
