require 'glassfrog/base'
require 'glassfrog/rest/get'
require 'glassfrog/rest/post'
require 'glassfrog/rest/patch'
require 'glassfrog/rest/delete'

module Glassfrog
  # 
  # Encapsulates GlassFrog Projects.
  # 
  class Project < Glassfrog::Base
    # @return [String]
    attr_accessor :description, :status, :link, :created_at, :archived_at
    # @return [Integer]
    attr_accessor :value, :effort, :roi
    # @return [Boolean]
    attr_accessor :private_to_circle
    # @return [Hash]
    attr_accessor :links
    PATH = '/projects'
    TYPE = :projects

    # 
    # Sends a GET request for Project(s) to GlassFrog.
    # @param client [Glassfrog::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassfrog::Base] The options used to find the correct Projects(s).
    # 
    # @return [Array<Glassfrog::Project>] The array of Project(s) fetched from GlassFrog.
    def self.get(client, options)
      response = Glassfrog::REST::Get.get(client, PATH, options)
      response[TYPE].map { |object| self.new(object) }
    end

    # 
    # Sends a POST request to create a Project on GlassFrog.
    # @param client [Glassforg::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassforg::Base] The options used to create the new Projects.
    # 
    # @return [Array<Glassfrog::Project>] The array containing the new Project.
    def self.post(client, options)
      response = Glassfrog::REST::Post.post(client, PATH, { TYPE => [parse_options(options)] })
      response[TYPE].map { |object| self.new(object) }
    end

    # 
    # Sends a PATCH request to update a Project on GlassFrog.
    # @param client [Glassforg::Client] The client that will send the request. Contains the API key.
    # @param identifier [Integer] The ID of the Project to be updated.
    # @param options [Hash, Glassfrog::Base] The options used to update the Project.
    # 
    # @return [Boolean] Whether the request failed or not.
    def self.patch(client, identifier, options)
      options = Glassfrog::REST::Patch.formify(parse_options(options), self)
      response = Glassfrog::REST::Patch.patch(client, PATH + '/' + identifier.to_s, options)
    end

    # 
    # Sends a DELETE request to delete a Project on GlassFrog.
    # @param client [Glassforg::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassfrog::Base] The options containing the ID of the Project to delete.
    # 
    # @return [Boolean] Whether the request failed or not.
    def self.delete(client, options)
      path = PATH + '/' + options.delete(:id).to_s
      response = Glassfrog::REST::Delete.delete(client, path, options)
    end

    private

    PARAMS = [
      :description,
      :status,
      :link,
      :value,
      :effort,
      :private_to_circle,
      :archived_at,
      :circle_id,
      :role_id,
      :person_id
    ]

    # 
    # Grabs only the parameters accepted by GlassFrog.
    # @param options [Hash] Inputed options.
    # 
    # @return [Hash] Valid GlassFrog options.
    def self.parse_options(options)
      options[:circle_id] = options[:links][:circle] if options[:links] && options[:links][:circle]
      options[:role_id] = options[:links][:role] if options[:links] && options[:links][:role]
      options[:person_id] = options[:links][:person] if options[:links] && options[:links][:person]
      params_hash = Hash.new
      PARAMS.each { |param| params_hash[param] = options[param] if options[param] }
      params_hash
    end
  end
end