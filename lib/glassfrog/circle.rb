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
    attr_accessor :links
    PATH = '/circles'

    # 
    # Sends a GET request for Circle(s) to GlassFrog.
    # @param client [Glassfrog::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassfrog::Base] The options used to find the correct Circles(s).
    # 
    # @return [Array<Glassfrog::Circle>] The array of Circle(s) fetched from GlassFrog.
    def self.get(client, options)
      options = options.is_a?(Glassfrog::Base) ? options.hashify : options
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Get.get(client, path, options)
      response[:circles].map { |circle| self.new(circle) }
    end
  end
end