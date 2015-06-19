require 'glassfrog/base'
require 'glassfrog/rest/get'
require 'glassfrog/rest/post'
require 'glassfrog/rest/patch'
require 'glassfrog/rest/delete'

module Glassfrog
  class Person < Glassfrog::Base
    attr_accessor :name, :email, :external_id, :links
    PATH = '/people'

    def self.get(client, options)
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Get.get(client, path, options)
      response['people'].map { |person| self.new(person) }
    end

    def self.post(client, options)
      options = options.is_a? Glassfrog::Person ? options.hashify : options
      options = { people: [ options ] }.to_json
      response = Glassfrog::REST::Post.post(client, PATH, options)
    end

    def self.patch(client, identifier, options)
      path = PATH + '/' + identifier
      options = options.is_a? Glassfrog::Person ? options.hashify : options
      options = formify(options)
      response = Glassfrog::REST::Patch.patch(client, path, options)
    end

    def self.delete(client, options)
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Delete.delete(client, path, options)
    end
  end
end