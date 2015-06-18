require 'glassfrog/rest/get'
require 'glassfrog/rest/patch'

module Glassfrog
  class Role
    attr_accessor :id, :name, :purpose, :links

    def self.get(options)
      response = Glassfrog::REST::Get.get('/roles', options)
    end

    def self.patch(options)
      response = Glassfrog::REST::Patch.patch('/roles', options)
    end

    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end
  end
end