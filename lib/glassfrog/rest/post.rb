require 'glassfrog/rest/request'

module Glassfrog
  module REST
      # 
      # Encapsulates all POST requests.
      # 
    module Post
      # 
      # Sends a POST request.
      # @param client [Glassfrog::Client] Client that will send the request.
      # @param path [String] Path to send request to.
      # @param options [Hash] Options being sent in the request.
      # 
      # @return [Array<Hash>] Array containing a Hash for the object created.
      def self.post(client, path, options)
        Glassfrog::REST::Request.new(client, :post, path, options).perform
      end
    end
  end
end