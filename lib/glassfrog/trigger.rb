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
    TYPE = :triggers

    # 
    # Sends a GET request for Trigger(s) to GlassFrog.
    # @param client [Glassfrog::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassfrog::Base] The options used to find the correct Triggers(s).
    # 
    # @return [Array<Glassfrog::Trigger>] The array of Trigger(s) fetched from GlassFrog.
    def self.get(client, options)
      response = Glassfrog::REST::Get.irregular_get(client, TYPE, PATH, options)
      response[TYPE] ? response[TYPE].map { |object| self.new(object) } : []
    end
  end
end