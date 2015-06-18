require 'glassfrog/rest/get'

module Glassfrog
  class Circle
    attr_accessor :id, :name, :short_name, :strategy, :links

    def self.get(client, options)
      response = Glassfrog::REST::Get.get(client, '/circles', options)
    end

    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end
  end
end