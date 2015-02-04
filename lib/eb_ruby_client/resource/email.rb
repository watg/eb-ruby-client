require 'eb_ruby_client/resource/attributes'

module EbRubyClient
  module Resource
    class Email
      include Attributes

      def initialize(data)
        set_attributes(data)
      end
    end
  end
end
