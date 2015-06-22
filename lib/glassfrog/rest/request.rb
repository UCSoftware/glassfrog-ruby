require 'addressable/uri'
require 'http'
require 'glassfrog/error'
require 'glassfrog/utils/utils'

module Glassfrog
  module REST
    class Request
      include Glassfrog::Utils
      attr_accessor :client, :headers, :options, :request_method, :uri
      ROOT_URL = 'https://glassfrog.holacracy.org/api/v3'

      def initialize(client, request_method, path, options)
        @client = client
        @headers = client.headers
        @request_method = request_method
        @uri = Addressable::URI.parse(path.start_with?('http') ? path : ROOT_URL + path)
        @options = options
      end

      def perform
        options_key = @request_method == (:get || :patch) ? :params : :form
        response = HTTP.headers(@headers).public_send(@request_method, @uri.to_s, options_key => @options)
        fail_or_return_response_body(response.code, response, response.headers)
      end

      private

      def fail_or_return_response_body(code, body, headers)
        error = error(code, body, headers)
        fail(error) if error
        symbolize_keys(body.parse)
      end

      def error(code, body, headers)
        klass = Glassfrog::Error::ERRORS[code]
        klass.from_response(code, body, headers) if !klass.nil?
      end
    end
  end
end