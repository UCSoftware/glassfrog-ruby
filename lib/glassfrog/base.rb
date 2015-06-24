require 'glassfrog/utils/utils'

module Glassfrog
  class Base
    include Glassfrog::Utils
    attr_accessor :id
    
    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end

    def ==(other)
      self.id == other.id && self.class == other.class
    end

    def hashify
      hash = Hash.new
      self.instance_variables.each { |var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }
      symbolize_keys(hash)
    end
  end
end