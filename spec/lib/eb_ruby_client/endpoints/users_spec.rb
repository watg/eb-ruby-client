require 'eb_ruby_client'

RSpec.describe EbRubyClient::Endpoints::Users do
  let(:connection) { instance_double(EbRubyClient::Connection) }
  let(:response) { {"id" => "123"} }

  subject(:users) { EbRubyClient::Endpoints::Users.new(connection: connection) }

  before do
    allow(connection).to receive(:get).and_return(response)
  end

  describe "me" do
    it "makes a GET request to API endpoint" do
      users.me
      expect(connection).to have_received(:get).with("users/me")
    end

    it "returns a User resource" do
      user = double(EbRubyClient::Resource::User)
      expect(EbRubyClient::Resource::User).to receive(:new).with(response).and_return(user)
      expect(users.me).to be(user)
    end
  end

  describe "organizers" do
    let(:response) { { "organizers" => [organizer_one, organizer_two] } }
    let(:organizer_one) { { "name" => "Ed" } }
    let(:organizer_two) { { "name" => "Fred" } }

    it "makes a GET request to the API endpoint" do
      users.organizers(user_id: 1234)
      expect(connection).to have_received(:get).with("users/1234/organizers")
    end

    it 'returns an array of organizers' do
      organizer_resource_one = double(EbRubyClient::Resource::Organizer)
      organizer_resource_two = double(EbRubyClient::Resource::Organizer)
      expect(EbRubyClient::Resource::Organizer).to receive(:new).with(organizer_one).and_return(organizer_resource_one)
      expect(EbRubyClient::Resource::Organizer).to receive(:new).with(organizer_two).and_return(organizer_resource_two)
      expect(users.organizers(user_id: 1234)).to eq([organizer_resource_one, organizer_resource_two])
    end
  end
end
