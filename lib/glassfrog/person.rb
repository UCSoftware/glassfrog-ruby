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
      options = options.is_a?(Glassfrog::Base) ? options.hashify : options
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Get.get(client, path, options)
      response[:people].map { |person| self.new(person) }
    end

    def self.post(client, options)
      options = options.is_a?(Glassfrog::Person) ? options.hashify : options
      response = Glassfrog::REST::Post.post(client, PATH, { people: [parse_options(options)] })
      response[:people].map { |person| self.new(person) }
    end

    def self.patch(client, identifier, options)
      path = PATH + '/' + identifier.to_s
      options = options.is_a?(Glassfrog::Person) ? options.hashify : options
      options = Glassfrog::REST::Patch.formify(parse_options(options), self)
      response = Glassfrog::REST::Patch.patch(client, path, options)
    end

    def self.delete(client, options)
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Delete.delete(client, path, options)
    end

    private

    PARAMS = [
      :name,
      :email
    ]

    def self.parse_options(options)
      params_hash = Hash.new
      PARAMS.each { |param| params_hash[param] = options[param] if options[param] }
      params_hash
    end
  end
end