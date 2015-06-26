require 'glassfrog/utils/utils'

module Glassfrog
  # 
  # Superclass of all GlassFrog classes.
  # 
  class Base
    include Glassfrog::Utils
    # @return [Integer]
    attr_accessor :id
    
    # 
    # Initializes a new Base object.
    # @param attrs = {} [Hash] Attributes used to instantiate Base object.
    # 
    # @return [Glassfrog::Base] The new Base object.
    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end

    def ==(other)
      self.id == other.id && self.class == other.class
    end

    # 
    # Turns the Base object into a hash.
    # 
    # @return [Hash] Hash version of the Base object.
    def hashify
      hash = Hash.new
      self.instance_variables.each { |var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }
      symbolize_keys(hash)
    end
  end
end