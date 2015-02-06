require 'eb_ruby_client/support/attributes'

RSpec.describe EbRubyClient::Support::Attributes do
  class AttributeTest
    include EbRubyClient::Support::Attributes

    attr_accessor :attribute1, :attribute2, :attribute3
  end

  subject(:test_class) { AttributeTest.new }

  describe "set_attributes" do
    it "sets any attributes that exist" do
      test_class.set_attributes(attribute1: "value 1", attribute3: "value 2")
      expect(test_class.attribute1).to eq("value 1")
      expect(test_class.attribute2).to be_nil
      expect(test_class.attribute3).to eq("value 2")
    end

    it "skips attributes that don't exist" do
      expect {
        test_class.set_attributes(attribute1: "value 1", attribute99: "value 2")
      }.not_to raise_error
      expect(test_class.attribute1).to eq("value 1")
      expect(test_class.attribute2).to be_nil
      expect(test_class.attribute3).to be_nil
    end
  end
end
