require 'addressable/uri'
require 'http'

module Glassfrog
  module REST
    class Request
      ROOT_URL = 'https://glassfrog.holacracy.org/api/v3'
      attr_accessor :client, :headers, :options, :request_method, :uri

      def initialize(client, request_method, path, options={})
        @client = client
        @headers = client.headers
        @request_method = request_method
        @uri = Addressable::URI.parse(path.start_with?('http') ? path : ROOT_URL + path)
        @options = symbolize_keys!(options)
      end

      def perform
        options_key = @request_method == (:get || :patch) ? :params : :form
        response = HTTP.headers(@headers).accept(:json).public_send(@request_method, @uri.to_s, options_key => @options)
        response_body = symobolize_keys!(response.parse)
        response_headers = response.headers
        fail_or_return_response_body(response.code, response_body, response_headers)
      end

      private

      def symbolize_keys!(object)
        if object.is_a?(Array)
          object.each_with_index do |val, index|
            object[index] = symbolize_keys!(val)
          end
        elsif object.is_a?(Hash)
          object.keys.each do |key|
            object[key.to_sym] = symbolize_keys!(object.delete(key))
          end
        end
        object
      end
    end
  end
end