require 'eb_ruby_client/resource/attributes'

module EbRubyClient
  module Resource
    class User
      include Attributes

      attribute :id, :name, :first_name, :last_name

      def initialize(data)
        set_attributes(data)
      end
    end
  end
end
