require 'eb_ruby_client/resource/attributes'
require 'eb_ruby_client/resource/email'

module EbRubyClient
  module Resource
    class User
      include Attributes

      attribute :id, :name, :first_name, :last_name
      contains :emails

      def initialize(data)
        set_attributes(data)
      end
    end
  end
end
