require 'glassfrog/rest/get'

module Glassfrog
  class Action
    attr_accessor :id, :description, :private_to_circle, :created_at, :links

    def self.get(options)
      response = Glassfrog::REST::Get.get('/actions', options)
    end

    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end
  end
end