require 'glassfrog/base'
require 'glassfrog/rest/get'
require 'glassfrog/rest/patch'

module Glassfrog
  class Role < Glassfrog::Base
    attr_accessor :name, :purpose, :links
    PATH = '/roles'

    def self.get(client, options)
      options = options.is_a?(Glassfrog::Base) ? options.hashify : options
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Get.get(client, path, options)
      response[:roles].map { |role| self.new(role) }
    end

    def self.patch(client, identifier, options)
      path = PATH + '/' + identifier.to_s
      options = options.is_a?(Glassfrog::Role) ? options.hashify : options
      options = Glassfrog::REST::Patch.formify(parse_options(options), self)
      response = Glassfrog::REST::Patch.patch(client, path, options)
    end

    def name_parameterized
      parameterize(@name)
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