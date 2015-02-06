require 'eb_ruby_client/support/inflections'

module EbRubyClient
  module Support
    module Members
      include EbRubyClient::Support::Inflections

      def set_members(data)
        valid_member_names(data).each do |name|
          resource_class = resource_for(name)
          resources = data.fetch(name).map do |resource_data|
            resource_class.new(resource_data)
          end
          self.send("#{name}=", resources)
        end
      end

      def resource_for(name)
        resource_name = classify(name.to_s)
        EbRubyClient::Resource.const_get(resource_name)
      end

      private

      def valid_member_names(data)
        data.keys.select do |m|
          self.class.member_names.include?(m.to_sym)
        end
      end
    end

    module MembersClassMethods
      MEMBERS = :@@_members

      def contains_many(*names)
        names.each do |name|
          attr_accessor name
        end
        class_variable_set(MEMBERS, member_names + names)
      end

      def member_names
        if class_variable_defined?(MEMBERS)
          class_variable_get(MEMBERS)
        else
          []
        end
      end
    end
  end
end
