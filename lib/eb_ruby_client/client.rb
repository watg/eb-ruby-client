require 'eb_ruby_client/configuration'
require 'eb_ruby_client/connection'
require 'eb_ruby_client/endpoints/users'

module EbRubyClient
  class Client
    attr_reader :connection

    def initialize
      @connection = Connection.new(configuration: Configuration.new)
    end

    def users
      Endpoints::Users.new(connection: connection)
    end
  end
end
