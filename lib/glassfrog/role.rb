require 'glassfrog/base'
require 'glassfrog/rest/get'
require 'glassfrog/rest/patch'

module Glassfrog
  class Role < Glassfrog::Base
    attr_accessor :name, :purpose, :links
    PATH = '/roles'
    PATCH_PATH = '/roles/0/links/people/'

    def self.get(client, options)
      options = options.is_a?(Glassfrog::Base) ? options.hashify : options
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Get.get(client, path, options)
      response[:roles].map { |role| self.new(role) }
    end

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

    def name_parameterized
      parameterize(@name)
    end

    private

    PARAMS = [
      :people
    ]

    def self.parse_options(options)
      options[:people] = options[:links][:people] if options[:links] && options[:links][:people]
      params_hash = Hash.new
      PARAMS.each { |param| params_hash[param] = options[param] if options[param] }
      params_hash
    end

    def self.formify_role_patch(options, operation)
      options.keys.map do |key|
        { op: operation,
          path: PATCH_PATH + options[key].to_s }
      end
    end
  end
end