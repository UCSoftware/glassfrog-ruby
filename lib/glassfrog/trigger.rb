require 'glassfrog/base'
require 'glassfrog/rest/get'

module Glassfrog
  class Trigger < Glassfrog::Base
    attr_accessor :description, :private_to_circle, :created_at, :links
    PATH = '/triggers'

    def self.get(client, options)
      options = options.is_a?(Glassfrog::Base) ? options.hashify : options
      if options.is_a?(Hash) && options[:id]
        response = Glassfrog::REST::Get.get(client, PATH, {})
        if response[:triggers] then response[:triggers].select! { |trigger| trigger[:id] == options[:id] } end
      else 
        response = Glassfrog::REST::Get.get(client, PATH, options)
      end
      response[:triggers] ? response[:triggers].map { |trigger| self.new(trigger) } : []
    end
  end
end