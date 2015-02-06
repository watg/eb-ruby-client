require 'eb_ruby_client/support/attributes'
require 'eb_ruby_client/support/members'

module EbRubyClient
  module Support
    module Resource
      include Attributes
      include Members

      def self.included(base)
        base.extend(MembersClassMethods)
      end
    end
  end
end
