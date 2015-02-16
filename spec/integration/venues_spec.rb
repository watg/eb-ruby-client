require 'eb_ruby_client'

RSpec.describe "venues" do
  include RSpec::Fixtures

  subject(:client) { EbRubyClient::Client.new }

  before do
    EbRubyClient::Configuration.config_file_path = File.expand_path("../../config/eventbrite.yml", __FILE__)

    stub_request(:post, "https://test.eventbrite.url/api/venues/").
      to_return(body: fixture("venues/create"))
  end

  describe "create" do
    it "returns the created venue" do
      venue = EbRubyClient::Resource::Venue.new(
        "name"    => "Betty's House",
        "address" => {
          "address_1"   => "123 Some Street",
          "city"        => "London",
          "postal_code" => "POST CODE",
          "country"     => "GB",
        }
      )

      returned_venue = client.venues.create(venue)
      expect(returned_venue.name).to eq("venue1")
      expect(returned_venue.id).to eq("1234")
      expect(returned_venue.address.address_1).to eq("Apartment 106")
    end
  end
end
