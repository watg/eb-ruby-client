require 'eb_ruby_client/resource/user'

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
    end
  end
end
