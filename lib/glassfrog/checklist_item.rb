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
      response['checklist_items'].map { |checklist_item| self.new(checklist_item) }
    end

    def self.post(client, options)
      options = options.is_a? Glassfrog::ChecklistItem ? options.hashify : options
      options = { checklist_items: [ options ] }.to_json
      response = Glassfrog::REST::Post.post(client, PATH, options)
    end

    def self.patch(client, identifier, options)
      path = PATH + '/' + identifier
      options = options.is_a? Glassfrog::ChecklistItem ? options.hashify : options
      options = formify(options)
      response = Glassfrog::REST::Patch.patch(client, PATH, options)
    end

    def self.delete(client, options)
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Delete.delete(client, path, options)
    end
  end
end