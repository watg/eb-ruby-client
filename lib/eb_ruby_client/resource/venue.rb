require 'eb_ruby_client/support/resource'
require 'eb_ruby_client/resource/address'

module EbRubyClient
  module Resource
    class Venue
      include EbRubyClient::Support::Resource

      attr_accessor :name, :id, :resource_uri, :latitude, :longitude
      contains_one :address

      def initialize(data)
        set_attributes(data)
        set_members(data)
      end

      def to_data
        {"venue.name" => name, "venue.address" => address.to_data }
      end
    end
  end
end
