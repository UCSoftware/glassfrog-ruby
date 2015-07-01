require 'glassfrog/base'
require 'glassfrog/rest/get'

module Glassfrog
  # 
  # Encapsulates GlassFrog Actions.
  # 
  class Action < Glassfrog::Base
    # @return [String]
    attr_accessor :description, :created_at
    # @return [Boolean]
    attr_accessor :private_to_circle
    # @return [Hash]
    attr_accessor :links
    PATH = '/actions'

    # 
    # Sends a GET request for Action(s) to GlassFrog.
    # @param client [Glassfrog::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassfrog::Base] The options used to find the correct Actions(s).
    # 
    # @return [Array<Glassfrog::Action>] The array of Action(s) fetched from GlassFrog.
    def self.get(client, options)
      options = options.is_a?(Glassfrog::Base) ? options.hashify : options
      if options.is_a?(Hash) && options[:id]
        response = Glassfrog::REST::Get.get(client, PATH, {})
        if response[:actions] then response[:actions].select! { |action| action[:id] == options[:id] } end
      else 
        response = Glassfrog::REST::Get.get(client, PATH, options)
      end
      response[:actions] ? response[:actions].map { |action| self.new(action) } : []
    end
  end
end