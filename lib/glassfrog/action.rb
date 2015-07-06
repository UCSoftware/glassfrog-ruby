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
    TYPE = :actions

    # 
    # Sends a GET request for Action(s) to GlassFrog.
    # @param client [Glassfrog::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassfrog::Base] The options used to find the correct Actions(s).
    # 
    # @return [Array<Glassfrog::Action>] The array of Action(s) fetched from GlassFrog.
    def self.get(client, options)
      response = Glassfrog::REST::Get.irregular_get(client, TYPE, PATH, options)
      response[TYPE] ? response[TYPE].map { |object| self.new(object) } : []
    end
  end
end