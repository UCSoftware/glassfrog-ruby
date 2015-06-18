module Glassfrog
  class Person
    attr_accessor :id, :name, :email, :external_id, :links

    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end
  end
end