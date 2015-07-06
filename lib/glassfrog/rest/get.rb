require 'glassfrog/rest/request'

module Glassfrog
  module REST
      # 
      # Encapsulates all GET requests.
      # 
    module Get
      # 
      # Sends a GET request.
      # @param client [Glassfrog::Client] Client that will send the request.
      # @param path [String] Path to send request to.
      # @param options [Hash] Options being sent in the request.
      # 
      # @return [Array<Hash>] Array containing Hashes of objects fetched.
      def self.get(client, path, options)
        path = options[:id] ? path + '/' + options.delete(:id).to_s : path
        Glassfrog::REST::Request.new(client, :get, path, options).perform
      end

      # 
      # Handles GET requests for objects that do not have a native get with ID method on GlassFrog.
      # @param client [Glassfrog::Client] Client that will send the request.
      # @param type [Symbol] The symbol of the object type being fetched to be used as a key in the response hash.
      # @param path [String] Path to send request to.
      # @param options [Hash] Options being sent in the request.
      # 
      # @return [Array<Hash>] Array containing Hashes of objects fetched.
      def self.irregular_get(client, type, path, options)
        if options.is_a?(Hash) && options[:id]
          response = get(client, path, {})
          if response[type] then response[type].select! { |object| object[:id] == options[:id] } end
        else
          response = get(client, path, options)
        end
        response
      end
    end
  end
end