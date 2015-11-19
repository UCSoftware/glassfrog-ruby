require 'glassfrog/base'
require 'glassfrog/rest/get'

module Glassfrog
  # 
  # Encapsulates GlassFrog Circles.
  # 
  class Circle < Glassfrog::Base
    # @return [String]
    attr_accessor :name, :short_name, :strategy
    # @return [Hash]
    attr_accessor :links, :roles
    # @return [Array<Glassfrog::Circle]
    attr_accessor :sub_circles
    PATH = '/circles'
    TYPE = :circles

    LINK_TYPES = [:roles]

    # 
    # Sends a GET request for Circle(s) to GlassFrog.
    # @param client [Glassfrog::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassfrog::Base] The options used to find the correct Circles(s).
    # 
    # @return [Array<Glassfrog::Circle>] The array of Circle(s) fetched from GlassFrog.
    def self.get(client, options)
      response = Glassfrog::REST::Get.get(client, PATH, options)
      response[TYPE].map do |object|
        circle = self.new(object)
        LINK_TYPES.each { |type| circle.build_link_objects(response, type) }
        circle
      end
    end
  end
end
