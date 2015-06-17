module Glassfrog
  class Circle
    attr_accessor :id, :name, :short_name, :strategy, :links

    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end
  end
end