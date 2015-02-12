require 'eb_ruby_client/resource/address'

RSpec.describe EbRubyClient::Resource::Address do
  let(:data) {{
    "address_1"    => "Apartment 106",
    "address_2"    => "45 Royal Street",
    "city"         => "London",
    "region"       => "London",
    "postal_code"  => "SW1A 1AA",
    "country"      => "GB",
    "country_name" => "United Kingdom",
    "latitude"     => "37.782222",
    "longitude"    => "-122.40551",
  }}

  subject(:address) { EbRubyClient::Resource::Address.new(data) }

  describe "initialize" do
    it "sets the address_1" do
      expect(address.address_1).to eq("Apartment 106")
    end

    it "sets the address_2" do
      expect(address.address_2).to eq("45 Royal Street")
    end

    it "sets the city" do
      expect(address.city).to eq("London")
    end

    it "sets the region" do
      expect(address.region).to eq("London")
    end

    it "sets the country" do
      expect(address.country).to eq("GB")
    end

    it "sets the country_name" do
      expect(address.country_name).to eq("United Kingdom")
    end

    it "sets the latitude" do
      expect(address.latitude).to eq("37.782222")
    end

    it "sets the longitude" do
      expect(address.longitude).to eq("-122.40551")
    end
  end

  describe "#to_data" do
    subject(:address_data) { address.to_data }

    it "includes the address details" do
      expect(address_data["address_1"]).to eq("Apartment 106")
      expect(address_data["address_2"]).to eq("45 Royal Street")
      expect(address_data["city"]).to eq("London")
      expect(address_data["region"]).to eq("London")
      expect(address_data["postal_code"]).to eq("SW1A 1AA")
      expect(address_data["country"]).to eq("GB")
    end

    it "treats address_2 as optional" do
      address.address_2 = nil
      expect(address_data).not_to have_key("address_2")
    end

    it "treats city as optional" do
      address.city = nil
      expect(address_data).not_to have_key("city")
    end

    it "treats region as optional" do
      address.region = nil
      expect(address_data).not_to have_key("region")
    end

    it "treats postal_code as optional" do
      address.postal_code = nil
      expect(address_data).not_to have_key("postal_code")
    end

  end
end
