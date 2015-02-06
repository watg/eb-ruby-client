require 'eb_ruby_client/resource/organizer'

RSpec.describe EbRubyClient::Resource::Organizer do
  let(:data) {{
    "description" => nil,
    "logo" => nil,
    "resource_uri" => "https://www.eventbriteapi.com/v3/organizers/123/",
    "id" => "123",
    "name" => "Betty Person",
    "url" => "http://www.eventbrite.com/o/betty-person-456",
    "num_past_events" => 0,
    "num_future_events" => 0
  }}


  subject(:organizer) { EbRubyClient::Resource::Organizer.new(data) }

  describe "initialize" do
    it "sets the description" do
      expect(organizer.description).to be_nil
    end

    it "sets the logo" do
      expect(organizer.logo).to be_nil
    end

    it "sets the resource_uri" do
      expect(organizer.resource_uri).to eq("https://www.eventbriteapi.com/v3/organizers/123/")
    end

    it "sets the id" do
      expect(organizer.id).to eq("123")
    end

    it "sets the name" do
      expect(organizer.name).to eq("Betty Person")
    end

    it "sets the url" do
      expect(organizer.url).to eq("http://www.eventbrite.com/o/betty-person-456")
    end

    it "sets the num_past_events" do
      expect(organizer.num_past_events).to eq(0)
    end

    it "sets the num_future_events" do
      expect(organizer.num_future_events).to eq(0)
    end
  end
end
