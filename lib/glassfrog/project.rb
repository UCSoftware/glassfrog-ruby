require 'glassfrog/base'
require 'glassfrog/rest/get'
require 'glassfrog/rest/post'
require 'glassfrog/rest/patch'
require 'glassfrog/rest/delete'

module Glassfrog
  class Project < Glassfrog::Base
    attr_accessor :description, :status, :link, :value, :effort, :roi, 
                  :private_to_circle, :created_at, :archived_at, :links
    PATH = '/projects'

    def self.get(client, options)
      options = options.is_a?(Glassfrog::Base) ? options.hashify : options
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Get.get(client, path, options)
      response[:projects].map { |project| self.new(project) }
    end

    def self.post(client, options)
      options = options.is_a?(Glassfrog::Project) ? options.hashify : options
      response = Glassfrog::REST::Post.post(client, PATH, parse_options(options))
      response[:projects].map { |project| self.new(project) }
    end

    def self.patch(client, identifier, options)
      path = PATH + '/' + identifier
      options = options.is_a? Glassfrog::Project ? options.hashify : options
      options = formify(options)
      response = Glassfrog::REST::Patch.patch(client, path, options)
    end

    def self.delete(client, options)
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
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

    def self.parse_options(options)
      options[:circle_id] = options[:links][:circle] if options[:links] && options[:links][:circle]
      options[:role_id] = options[:links][:role] if options[:links] && options[:links][:role]
      options[:person_id] = options[:links][:person] if options[:links] && options[:links][:person]
      params_hash = Hash.new
      PARAMS.each { |param| params_hash[param] = options[param] if options[param] }
      { projects: [params_hash] }
    end
  end
end