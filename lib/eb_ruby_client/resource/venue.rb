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
        data = {"venue.name" => name}
        address.to_data.inject(data) do |acc, next_pair|
          k, v = next_pair
          acc["venue.address.#{k}"] = v
          acc
        end
      end
    end
  end
end
