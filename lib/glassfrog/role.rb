require 'glassfrog/base'
require 'glassfrog/rest/get'
require 'glassfrog/rest/patch'
require 'glassfrog/link_factory'

module Glassfrog
  # 
  # Encapsulates GlassFrog Roles.
  # 
  class Role < Glassfrog::Base
    # @return [String]
    attr_accessor :name, :purpose
    # @return [Hash]
    attr_accessor :links, :accountabilities, :domains, :people
    PATH = '/roles'
    PATCH_PATH = '/roles/0/links/people/'
    TYPE = :roles

    LINK_TYPES = [:accountabilities, :domains, :people]

    LinkFactory.register(:roles, self)

    # 
    # Sends a GET request for Role(s) to GlassFrog.
    # @param client [Glassfrog::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassfrog::Base] The options used to find the correct Roles(s).
    # 
    # @return [Array<Glassfrog::Role>] The array of Role(s) fetched from GlassFrog.
    def self.get(client, options)
      response = Glassfrog::REST::Get.get(client, PATH, options)
      response[TYPE].map do |object|
        role = self.new(object)
        LINK_TYPES.each { |type| role.build_link_objects(response, type) }
        role
      end
    end

    # 
    # Sends a PATCH request to update a ChecklistItem on GlassFrog. Only updates the People assigned to the Role.
    # @param client [Glassforg::Client] The client that will send the request. Contains the API key.
    # @param identifier [Integer] The ID of the ChecklistItem to be updated.
    # @param options [Hash, Glassfrog::Base] The options used to update the ChecklistItem.
    # 
    # @return [Boolean] Whether the request failed or not.
    def self.patch(client, identifier, options)
      path = PATH + '/' + identifier.to_s
      current_object = self.get(client, { id: identifier }).first
      options = options.is_a?(Glassfrog::Role) ? parse_options(options.hashify) : parse_options(options)
      if current_object.links && current_object.links[:people] && options[:people]
        (options[:people] - current_object.links[:people]).each do |person_id|
          o = formify_role_patch({ person_id: person_id }, 'add')
          if !Glassfrog::REST::Patch.patch(client, path, o) then return false end
        end
        (current_object.links[:people] - options[:people]).each do |person_id|
          o = formify_role_patch({ person_id: person_id }, 'remove')
          if !Glassfrog::REST::Patch.patch(client, path, o) then return false end
        end
      else
        raise(ArgumentError, "No people found")
      end
      true
    end

    # 
    # Returns the name as a symbol with underscores instead of spaces.
    # 
    # @return [Symbol] The name as a symbol.
    def name_parameterized
      parameterize(@name)
    end

    private

    PARAMS = [
      :people
    ]

    # 
    # Grabs only the parameters accepted by GlassFrog.
    # @param options [Hash] Inputed options.
    # 
    # @return [Hash] Valid GlassFrog options.
    def self.parse_options(options)
      options[:people] = options[:links][:people] if options[:links] && options[:links][:people]
      params_hash = Hash.new
      PARAMS.each { |param| params_hash[param] = options[param] if options[param] }
      params_hash
    end

    # 
    # Turns options into the format to update GlassFrog.
    # @param options [Hash] Hash containing the Person to update the Roles of.
    # @param operation [String] The operation to perform, either 'Remove' or 'Add'.
    # 
    # @return [Hash] Formified options.
    def self.formify_role_patch(options, operation)
      options.keys.map do |key|
        { op: operation,
          path: PATCH_PATH + options[key].to_s }
      end
    end
  end
end
