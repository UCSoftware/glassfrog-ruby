require 'glassfrog/base'
require 'glassfrog/rest/get'
require 'glassfrog/rest/post'
require 'glassfrog/rest/patch'
require 'glassfrog/rest/delete'

module Glassfrog
  class ChecklistItem < Glassfrog::Base
    attr_accessor :description, :frequency, :global, :links
    PATH = '/checklist_items'

    def self.get(client, options)
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Get.get(client, path, options)
    end

    def self.post(client, options)
      path = PATH
      response = Glassfrog::REST::Post.post(client, path, options)
    end

    def self.patch(client, options)
      path = PATH
      response = Glassfrog::REST::Patch.patch(client, path, options)
    end

    def self.delete(client, options)
      path = PATH
      response = Glassfrog::REST::Delete.delete(client, path, options)
    end
  end
end