module Glassfrog
  class Base
    attr_accessor :id
    
    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end

    private

    def hashify
      hash = {}
      self.instance_variables.each { |var| hash[var.to_s.delete("@")] = gift.instance_variable_get(var) }
      hash
    end
  end
end