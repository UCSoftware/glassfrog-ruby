require 'glassfrog/rest/get'
require 'glassfrog/rest/post'
require 'glassfrog/rest/patch'
require 'glassfrog/rest/delete'

module Glassfrog
  class Person
    attr_accessor :id, :name, :email, :external_id, :links

    def self.get(options)
      response = Glassfrog::REST::Get.get('/people', options)
    end

    def self.post(options)
      response = Glassfrog::REST::Post.post('/people', options)
    end

    def self.patch(options)
      response = Glassfrog::REST::Patch.patch('/people', options)
    end

    def self.delete(options)
      response = Glassfrog::REST::Delete.delete('/people', options)
    end

    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end
  end
end