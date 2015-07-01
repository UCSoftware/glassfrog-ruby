require 'glassfrog/base'
require 'glassfrog/rest/get'

module Glassfrog
  # 
  # Encapsulates GlassFrog Actions.
  # 
  class Trigger < Glassfrog::Base
    # @return [String]
    attr_accessor :description, :created_at
    # @return [Boolean]
    attr_accessor :private_to_circle
    # @return [Hash]
    attr_accessor :links
    PATH = '/triggers'

    # 
    # Sends a GET request for Trigger(s) to GlassFrog.
    # @param client [Glassfrog::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassfrog::Base] The options used to find the correct Triggers(s).
    # 
    # @return [Array<Glassfrog::Trigger>] The array of Trigger(s) fetched from GlassFrog.
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