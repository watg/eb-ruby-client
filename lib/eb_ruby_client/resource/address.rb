require 'eb_ruby_client/support/resource'

module EbRubyClient
  module Resource
    class Address
      include EbRubyClient::Support::Resource

      attr_accessor :address_1, :address_2, :city,
        :region, :postal_code, :country, :country_name,
        :latitude, :longitude

      def initialize(data)
        set_attributes(data)
      end

      def to_data
        data = { 
          "address_1" => address_1,
          "country" => country,
        }

        data["address_2"] = address_2 if address_2
        data["city"] = city if city
        data["region"] = region if region
        data["postal_code"] = postal_code if postal_code

        data
      end
    end
  end
end
