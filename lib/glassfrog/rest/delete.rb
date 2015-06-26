require 'glassfrog/rest/request'

module Glassfrog
  module REST
      # 
      # Encapsulates all DELETE requests.
      # 
    module Delete
      # 
      # Sends a DELETE request.
      # @param client [Glassfrog::Client] Client that will send the request.
      # @param path [String] Path to send request to.
      # @param options [Hash] Options being sent in the request.
      # 
      # @return [Boolean] Whether request was successful.
      def self.delete(client, path, options)
        Glassfrog::REST::Request.new(client, :delete, path, options).perform
      end
    end
  end
end