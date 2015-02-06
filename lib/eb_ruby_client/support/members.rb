require 'eb_ruby_client/support/inflections'

module EbRubyClient
  module Support
    module Members
      include EbRubyClient::Support::Inflections

      def set_members(data)
        set_multiple_members(data)
        set_singular_members(data)
      end

      def set_multiple_members(data)
        valid_member_names(data, type: :multiple).each do |name|
          resource_class = resource_for(singularize(name.to_s))
          resources = data.fetch(name).map do |resource_data|
            resource_class.new(resource_data)
          end
          self.send("#{name}=", resources)
        end
      end

      def set_singular_members(data)
        valid_member_names(data, type: :singular).each do |name|
          resource_class = resource_for(name.to_s)
          resource = resource_class.new(data.fetch(name))
          self.send("#{name}=", resource)
        end
      end

      def resource_for(name)
        resource_name = classify(name)
        EbRubyClient::Resource.const_get(resource_name)
      end

      private

      def valid_member_names(data, type:)
        method = "#{type}_member_names"
        member_names = self.class.send(method)

        data.keys & member_names.map(&:to_s)
      end
    end

    module MembersClassMethods
      MULTIPLE_MEMBERS = :@@_multiple_members
      SINGULAR_MEMBERS = :@@_singular_members

      def contains_many(*names)
        names.each do |name|
          attr_accessor name
        end
        class_variable_set(MULTIPLE_MEMBERS, multiple_member_names + names)
      end

      def contains_one(*names)
        names.each do |name|
          attr_accessor name
        end
        class_variable_set(SINGULAR_MEMBERS, singular_member_names + names)
      end

      def multiple_member_names
        if class_variable_defined?(MULTIPLE_MEMBERS)
          class_variable_get(MULTIPLE_MEMBERS)
        else
          []
        end
      end

      def singular_member_names
        if class_variable_defined?(SINGULAR_MEMBERS)
          class_variable_get(SINGULAR_MEMBERS)
        else
          []
        end
      end
    end
  end
end
