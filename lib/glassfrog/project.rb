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
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Get.get(client, path, options)
      response[:projects].map { |project| self.new(project) }
    end

    def self.post(client, options)
      options = options.is_a? Glassfrog::Project ? options.hashify : options
      options = { projects: [ options ] }.to_json
      response = Glassfrog::REST::Post.post(client, PATH, options)
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
  end
end