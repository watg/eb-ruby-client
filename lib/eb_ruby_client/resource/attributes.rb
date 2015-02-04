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
      end

      private

      def attribute_names
        self.class.attribute_names
      end

      def given_attributes(data)
        data.keys & attribute_names
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
        class_variable_get(:@@_attributes)
      end
    end
  end
end
