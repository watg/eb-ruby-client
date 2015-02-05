module EbRubyClient
  module Support
    module Attributes
      def set_attributes(data)
        data.each_pair do |k, v|
          setter = "#{k}=".to_sym
          if self.respond_to?(setter)
            self.send(setter, v)
          end
        end
      end
    end
  end
end
