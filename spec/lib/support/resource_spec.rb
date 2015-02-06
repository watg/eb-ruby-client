require 'eb_ruby_client/support/resource'

RSpec.describe EbRubyClient::Support::Resource do
  let(:test_class) { Class.new.include(EbRubyClient::Support::Resource) }
  subject(:included_modules) { test_class.included_modules }
  subject(:extended_modules) { test_class.singleton_class.included_modules }

  describe "when included" do
    it "includes Attributes" do
      expect(included_modules).to include(EbRubyClient::Support::Attributes)
    end

    it "includes Members" do
      expect(included_modules).to include(EbRubyClient::Support::Members)
    end

    it "extends with MembersClassMethods" do
      expect(extended_modules).to include(EbRubyClient::Support::MembersClassMethods)
    end
  end
end
