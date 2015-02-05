require 'eb_ruby_client/support/resource'
require 'eb_ruby_client/resource/email'

module EbRubyClient
  module Resource
    class User
      include EbRubyClient::Support::Resource

      attr_accessor :id, :name, :first_name, :last_name
      contains_many :emails

      def initialize(data)
        set_attributes(data)
        set_members(data)
      end
    end
  end
end
