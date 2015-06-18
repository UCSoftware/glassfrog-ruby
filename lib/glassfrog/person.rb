require 'glassfrog/rest/get'
require 'glassfrog/rest/post'
require 'glassfrog/rest/patch'
require 'glassfrog/rest/delete'

module Glassfrog
  class Person
    attr_accessor :id, :name, :email, :external_id, :links

    def self.get(client, options)
      response = Glassfrog::REST::Get.get(client, '/people', options)
    end

    def self.post(client, options)
      response = Glassfrog::REST::Post.post(client, '/people', options)
    end

    def self.patch(client, options)
      response = Glassfrog::REST::Patch.patch(client, '/people', options)
    end

    def self.delete(client, options)
      response = Glassfrog::REST::Delete.delete(client, '/people', options)
    end

    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end
  end
end