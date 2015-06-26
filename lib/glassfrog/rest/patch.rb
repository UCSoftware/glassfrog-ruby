require 'glassfrog/rest/request'

module Glassfrog
  module REST
      # 
      # Encapsulates all PATCH requests.
      # 
    module Patch
      # 
      # Sends a PATCH request.
      # @param client [Glassfrog::Client] Client that will send the request.
      # @param path [String] Path to send request to.
      # @param options [Hash] Options being sent in the request.
      # 
      # @return [Boolean] Whether request was successful.
      def self.patch(client, path, options)
        Glassfrog::REST::Request.new(client, :patch, path, options).perform
      end

      # 
      # Turns options into PATCH form.
      # @param options [Hash] Options to be formified.
      # @param type [Class] Class being targeted by the request.
      # 
      # @return [Hash] Formified options.
      def self.formify(options, type)
        options.keys.map do |key|
         { op: 'replace',
           path: type::PATH + '/0/' + key.to_s,
           value: options[key] }
        end
      end
    end
  end
end