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
      options = options.is_a?(Glassfrog::Base) ? options.hashify : options
      if options.is_a?(Hash) && options[:id]
        response = Glassfrog::REST::Get.get(client, PATH, {})
        if response[:checklist_items] then response[:checklist_items].select! { |checklist_item| checklist_item[:id] == options[:id] } end
      else 
        response = Glassfrog::REST::Get.get(client, PATH, options)
      end
      response[:checklist_items] ? response[:checklist_items].map { |checklist_item| self.new(checklist_item) } : []
    end

    def self.post(client, options)
      options = options.is_a?(Glassfrog::ChecklistItem) ? options.hashify : options
      response = Glassfrog::REST::Post.post(client, PATH, { checklist_items: [parse_options(options)] })
      response[:checklist_items] ? response[:checklist_items].map { |checklist_item| self.new(checklist_item) } : []
    end

    def self.patch(client, identifier, options)
      path = PATH + '/' + identifier.to_s
      options = options.is_a?(Glassfrog::ChecklistItem) ? options.hashify : options
      options = Glassfrog::REST::Patch.formify(parse_options(options), self)
      response = Glassfrog::REST::Patch.patch(client, path, options)
    end

    def self.delete(client, options)
      options = options.is_a?(Glassfrog::Base) ? options.hashify : options
      path = PATH + '/' + options.delete(:id).to_s
      response = Glassfrog::REST::Delete.delete(client, path, options)
    end

    private

    PARAMS = [
      :description,
      :frequency,
      :global,
      :circle_id,
      :role_id
    ]

    def self.parse_options(options)
      options[:circle_id] = options[:links][:circle] if options[:links] && options[:links][:circle]
      options[:role_id] = options[:links][:role] if options[:links] && options[:links][:role]
      params_hash = Hash.new
      PARAMS.each { |param| params_hash[param] = options[param] if options[param] }
      params_hash
    end
  end
end