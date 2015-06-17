module Glassfrog
  class Role
    attr_accessor :id, :name, :purpose, :links

    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end
  end
end