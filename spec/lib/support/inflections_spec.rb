require 'eb_ruby_client/support/inflections'

RSpec.describe EbRubyClient::Support::Inflections do
  class InflectionTest
    include EbRubyClient::Support::Inflections
  end

  subject(:inflections) { InflectionTest.new }

  describe "singularize" do
    it "handles simple cases" do
      expect(inflections.singularize("events")).to eq("event")
    end

    it "handles words ending in 's'" do
      expect(inflections.singularize("addresses")).to eq("address")
    end

    it "handles words ending in 'y'" do
      expect(inflections.singularize("currencies")).to eq("currency")
    end

    it "handles words that are not plural" do
      expect(inflections.singularize("user")).to eq("user")
    end
  end

  describe "classify" do
    it "handles single words" do
      expect(inflections.classify("user")).to eq("User")
    end

    it "singularizes words" do
      expect(inflections.classify("users")).to eq("User")
    end

    it "handles underscores" do
      expect(inflections.classify("ticket_classes")).to eq("TicketClass")
    end

    it "handles words that are already valid class names" do
      expect(inflections.classify("Order")).to eq("Order")
    end
  end
end
