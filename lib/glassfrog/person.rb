require 'glassfrog/base'
require 'glassfrog/rest/get'
require 'glassfrog/rest/post'
require 'glassfrog/rest/patch'
require 'glassfrog/rest/delete'

module Glassfrog
  # 
  # Encapsulates GlassFrog People.
  # 
  class Person < Glassfrog::Base
    # @return [String]
    attr_accessor :name, :email
    # @return [Integer]
    attr_accessor :external_id
    # @return [Hash]
    attr_accessor :links
    PATH = '/people'
    TYPE = :people

    # 
    # Sends a GET request for Person(s) to GlassFrog.
    # @param client [Glassfrog::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassfrog::Base] The options used to find the correct Persons(s).
    # 
    # @return [Array<Glassfrog::Person>] The array of Person(s) fetched from GlassFrog.
    def self.get(client, options)
      response = Glassfrog::REST::Get.get(client, PATH, options)
      response[TYPE].map { |object| self.new(object) }
    end

    # 
    # Sends a POST request to create a Person on GlassFrog.
    # @param client [Glassforg::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassforg::Base] The options used to create the new Persons.
    # 
    # @return [Array<Glassfrog::Person>] The array containing the new Person.
    def self.post(client, options)
      response = Glassfrog::REST::Post.post(client, PATH, { TYPE => [parse_options(options)] })
      response[TYPE].map { |object| self.new(object) }
    end

    # 
    # Sends a PATCH request to update a Person on GlassFrog.
    # @param client [Glassforg::Client] The client that will send the request. Contains the API key.
    # @param identifier [Integer] The ID of the Person to be updated.
    # @param options [Hash, Glassfrog::Base] The options used to update the Person.
    # 
    # @return [Boolean] Whether the request failed or not.
    def self.patch(client, identifier, options)
      options = Glassfrog::REST::Patch.formify(parse_options(options), self)
      response = Glassfrog::REST::Patch.patch(client, PATH + '/' + identifier.to_s, options)
    end

    # 
    # Sends a DELETE request to delete a Person on GlassFrog.
    # @param client [Glassforg::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassfrog::Base] The options containing the ID of the Person to delete.
    # 
    # @return [Boolean] Whether the request failed or not.
    def self.delete(client, options)
      path = PATH + '/' + options.delete(:id).to_s
      response = Glassfrog::REST::Delete.delete(client, path, options)
    end

    private

    PARAMS = [
      :name,
      :email
    ]

    # 
    # Grabs only the parameters accepted by GlassFrog.
    # @param options [Hash] Inputed options.
    # 
    # @return [Hash] Valid GlassFrog options.
    def self.parse_options(options)
      params_hash = Hash.new
      PARAMS.each { |param| params_hash[param] = options[param] if options[param] }
      params_hash
    end
  end
end