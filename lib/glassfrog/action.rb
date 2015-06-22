require 'glassfrog/base'
require 'glassfrog/rest/get'

module Glassfrog
  class Action < Glassfrog::Base
    attr_accessor :description, :private_to_circle, :created_at, :links
    PATH = '/actions'

    def self.get(client, options)
      if options[:id]
        response = Glassfrog::REST::Get.get(client, PATH, {})
        if response[:actions] then response[:actions].select! { |action| action[:id] == options[:id] } end
      else 
        response = Glassfrog::REST::Get.get(client, PATH, options)
      end
      response[:actions] ? response[:actions].map { |action| self.new(action) } : []
    end
  end
end