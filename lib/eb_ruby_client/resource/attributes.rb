module EbRubyClient
  module Resource
    module Attributes
      def self.included(base)
        base.extend(AttributeClassMethods)
      end

      def set_attributes(data)
        given_attributes(data).each do |name|
          instance_variable_set("@#{name}".to_sym, data.fetch(name))
        end

        given_members(data).each do |member|
          members = data.fetch(member).map { |m| build_member(member, m) }
          instance_variable_set("@#{member}".to_sym, members)
        end
      end

      private

      def given_attributes(data)
        data.keys & self.class.attribute_names
      end

      def given_members(data)
        data.keys & self.class.member_names
      end

      def build_member(type, m)
        klass = self.class.member_class(type)
        klass.new(m)
      end
    end

    module AttributeClassMethods
      def attribute(*names)
        names.each do |name|
          attr_accessor name
        end
        class_variable_set(:@@_attributes, names.map(&:to_s))
      end

      def attribute_names
        if class_variable_defined?(:@@_attributes)
          class_variable_get(:@@_attributes)
        else
          []
        end
      end

      def contains(mappings)
        mappings.keys.each do |member|
          attr_accessor member
        end
        class_variable_set(:@@_member_names, mappings.keys.map(&:to_s))
        class_variable_set(:@@_members, mappings)
      end

      def member_names
        if class_variable_defined?(:@@_member_names)
          class_variable_get(:@@_member_names)
        else
          []
        end
      end

      def member_class(type)
        class_variable_get(:@@_members)[type.to_sym]
      end
    end
  end
end
