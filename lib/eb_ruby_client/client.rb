require 'eb_ruby_client/configuration'
require 'eb_ruby_client/connection'
require 'eb_ruby_client/endpoints/users'
require 'eb_ruby_client/endpoints/venues'

module EbRubyClient
  class Client
    attr_reader :connection

    def initialize
      @connection = Connection.new(configuration: Configuration.new)
    end

    def users
      Endpoints::Users.new(connection: connection)
    end

    def venues
      Endpoints::Venues.new(connection: connection)
    end
  end
end
