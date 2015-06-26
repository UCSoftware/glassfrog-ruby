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
        Glassfrog::REST::Request.new(client, :get, path, options).perform
      end
    end
  end
end