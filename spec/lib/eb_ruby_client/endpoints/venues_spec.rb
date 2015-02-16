require 'eb_ruby_client'

RSpec.describe EbRubyClient::Endpoints::Venues do
  let(:connection) { instance_double(EbRubyClient::Connection) }
  let(:response) { {"id" => "123"} }
  let(:new_venue) { instance_double(EbRubyClient::Resource::Venue, to_data: data) }
  let(:data) { {"thing" => "yup"} }

  subject(:venues) { EbRubyClient::Endpoints::Venues.new(connection: connection) }

  before do
    allow(connection).to receive(:post).and_return(response)
  end

  describe "create" do
    it "makes a POST request to API endpoint" do
      venues.create(new_venue)
      expect(connection).to have_received(:post).with("venues/", data)
    end

    it "returns a Venue resource" do
      venue = double(EbRubyClient::Resource::Venue)
      expect(EbRubyClient::Resource::Venue).to receive(:new).with(response).and_return(venue)
      expect(venues.create(new_venue)).to be(venue)
    end
  end
end
