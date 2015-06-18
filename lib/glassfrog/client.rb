require 'glassfrog/utils/utils'
require 'glassfrog/action'
require 'glassfrog/checklist_item'
require 'glassfrog/circle'
require 'glassfrog/metric'
require 'glassfrog/person'
require 'glassfrog/project'
require 'glassfrog/role'
require 'glassfrog/trigger'

module Glassfrog
  class Client
    include Glassfrog::Utils
    attr_accessor :api_key
    attr_reader :caching, :unrelenting

    TYPES = {
      action: Glassfrog::Action,
      checklist_item: Glassfrog::ChecklistItem,
      circle: Glassfrog::Circle,
      metric: Glassfrog::Metric,
      person: Glassfrog::Person,
      projoct: Glassfrog::Project,
      role: Glassfrog::Role,
      trigger: Glassfrog::Trigger,
    }

    TYPES.merge!({
      actions: TYPES[:action],
      checklist_items: TYPES[:checklist_item],
      circles: TYPES[:circle],
      metrics: TYPES[:metric],
      people: TYPES[:person],
      projects: TYPES[:project],
      roles: TYPES[:role],
      triggers: TYPES[:trigger]
    })

    def initialize(attrs={})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end

    def get(type, options={})
      options = parse_params(options)
      TYPES[type].public_send(:get, self, options)
    end

    def post(type, options={})
      TYPES[type].public_send(:post, self, options)
    end

    def patch(type, identifier, options={})
      identifier = parse_params(identifier)
      TYPES[type].public_send(:patch, self, identifier, options)
    end

    def delete(type, options={})
      options = parse_params(options)
      TYPES[type].public_send(:delete, self, options)
    end

    def headers
      { 'X-Auth-Token' => self.api_key }
    end

    def api_key?
      !!(api_key)
    end

    private

    def parse_params(options)
      id = extract_id(symbolize_keys!(options))
      id ? { id: id } : options
    end
  end
end