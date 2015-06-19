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
      project: Glassfrog::Project,
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

    ASSOCIATED_PARAMS = {
      Glassfrog::Role => {
        Glassfrog::Circle => [:circle_id, :id],
        Glassfrog::Person => [:person_id, :id] 
        },
      Glassfrog::Person => {
        Glassfrog::Circle => [:circle_id, :id],
        Glassfrog::Role => [:role, :name]
        },
      Glassfrog::Project => {
        Glassfrog::Circle => [:circle_id, :id],
        Glassfrog::Person => [:person_id, :id]
        },
      Glassfrog::Metric => {
        Glassfrog::Circle => [:circle_id, :id],
         Glassfrog::Role => [:role_id, :id]
         },
      Glassfrog::ChecklistItem => {
        Glassfrog::Circle => [:circle_id, :id]
        },
      Glassfrog::Action => {
        Glassfrog::Person => [:person_id, :id],
        Glassfrog::Circle => [:circle_id, :id]
        },
      Glassfrog::Trigger => {
        Glassfrog::Person => [:person_id, :id],
        Glassfrog::Circle => [:circle_id, :id]
      }
    }

    def initialize(attrs={})
      if attrs.class == String
        @api_key = attrs
      else
        attrs.each do |key, value|
          instance_variable_set("@#{key}", value);
        end
      end
      yield(self) if block_given?
    end

    def get(type, options={})
      klass = TYPES[type.to_sym]
      options = parse_params(options, klass)
      klass.public_send(:get, self, options)
    end

    # TO TEST
    def post(type, options={})
      klass = TYPES[type.to_sym]
      klass.public_send(:post, self, options)
    end

    # TO TEST
    def patch(type, identifier, options={})
      klass = TYPES[type.to_sym]
      identifier = parse_params(klass, identifier)
      klass.public_send(:patch, self, identifier, options)
    end

    # TO TEST
    def delete(type, options={})
      klass = TYPES[type.to_sym]
      options = parse_params(options, klass)
      klass.public_send(:delete, self, options)
    end

    def headers
      { 'X-Auth-Token' => self.api_key }
    end

    def api_key?
      !!(api_key)
    end

    private

    def parse_params(options, klass=nil)
      options = symbolize_keys(options)
      id = extract_id(options, klass)
      options = parse_associated_params(options, klass) unless id
      id ? { id: id } : options
    end

    def parse_associated_params(object, klass=nil)
      associated_param = ASSOCIATED_PARAMS[klass] ? ASSOCIATED_PARAMS[klass][object.class] : nil
      associated_param ? { associated_param[object.class][0] => object.public_send(associated_param[object.class][1]) } : object
    end
  end
end