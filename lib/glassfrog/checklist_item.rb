require 'glassfrog/rest/get'
require 'glassfrog/rest/post'
require 'glassfrog/rest/patch'
require 'glassfrog/rest/delete'

module Glassfrog
  class ChecklistItem
    attr_accessor :id, :description, :frequency, :global, :links

    def self.get(options)
      response = Glassfrog::REST::Get.get('/checklist_items', options)
    end

    def self.post(options)
      response = Glassfrog::REST::Post.post('/checklist_items', options)
    end

    def self.patch(options)
      response = Glassfrog::REST::Patch.patch('/checklist_items', options)
    end

    def self.delete(options)
      response = Glassfrog::REST::Delete.delete('/checklist_items', options)
    end

    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end
  end
end