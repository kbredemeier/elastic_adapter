module ElasticAdapter
  module AttributeAccessor
    module ClassMethods
      # Behaves similar to attr_reader but stores all
      # passed symbols in a class variable
      def attribute_reader(*args)
        @attributes ||= []

        args.each do |arg|
          @attributes << arg

          define_method arg.to_s do
            instance_variable_get("@#{arg}")
          end
        end
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    private

    # Returns an Array of all attributes defined with
    # attribute_reader
    def attributes
      self.class.instance_variable_get("@attributes")
    end
  end
end
