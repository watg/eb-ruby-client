require 'eb_ruby_client/resource/venue'

RSpec.describe EbRubyClient::Resource::Venue do
  let(:address_data) {{
    "address_1" => "1 Hyde Park",
    "city"      => "London"
  }}
  let(:data) {{
    "name"    => "Betty's house",
    "address" => address_data,
    "resource_uri" => "https://athing",
    "id" => "12345",
    "latitude" => "54.4",
    "longitude" => "-54.4"
  }}


  subject(:venue) { EbRubyClient::Resource::Venue.new(data) }

  describe "initialize" do
    it "sets the name" do
      expect(venue.name).to eq("Betty's house")
    end

    it "sets the resource_uri" do
      expect(venue.resource_uri).to eq("https://athing")
    end

    it "sets the id" do
      expect(venue.id).to eq("12345")
    end

    it "sets the latitude" do
      expect(venue.latitude).to eq("54.4")
    end

    it "sets the longitude" do
      expect(venue.longitude).to eq("-54.4")
    end

  end

  describe "address" do
    it "creates an address resource" do
      address = double(EbRubyClient::Resource::Address)
      expect(EbRubyClient::Resource::Address).to receive(:new).
        with(address_data).and_return(address)
      expect(venue.address).to be(address)
    end
  end

  describe "#to_data" do
    subject(:venue_data) { venue.to_data }

    it "includes the name" do
      expect(venue_data["venue.name"]).to eq("Betty's house")
    end

    it "includes the address" do
      expect(venue_data["venue.address.address_1"]).to eq(venue.address.address_1)
      expect(venue_data["venue.address.city"]).to eq(venue.address.city)
    end

  end
end
