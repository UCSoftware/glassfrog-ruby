require 'addressable/uri'
require 'glassfrog/client'
require 'glassfrog/error'
require 'glassfrog/utils/utils'

module Glassfrog
  module REST
    # 
    # Encapsulates an HTTP Request.
    # 
    class Request
      include Glassfrog::Utils
      # @return [Glassfrog::Client]
      attr_accessor :client
      # @return [Hash]
      attr_accessor :headers, :options
      # @return [Symbol]
      attr_accessor :request_method
      # @return [Addressable::URI]
      attr_accessor :uri
      ROOT_URL = 'https://glassfrog.holacracy.org/api/v3'

      REQUEST_ASSOCIATIONS = {
        get: :params,
        post: :json,
        patch: :json,
        delete: :form
      }

      # 
      # Initializes a new Request object.
      # @param client [Glassfrog::Client] The client that will send the request.
      # @param request_method [Symbol] The type of request that will be sent.
      # @param path [String] The path (minus the root) that the request will be sent to.
      # @param options [Hash] The options that will be included in the request.
      # 
      # @return [Glassfrog::Request] The initialized Request object.
      def initialize(client, request_method, path, options)
        @client = client
        @headers = client.headers
        @request_method = request_method
        @uri = Addressable::URI.parse(path.start_with?('http') ? path : ROOT_URL + path)
        @options = options
      end

      # 
      # Sends the Request.
      # 
      # @return [Array<Hash>, Boolean] The fetched or created parameters, or boolean reflecting whether the request was successful.
      def perform
        options_key = REQUEST_ASSOCIATIONS[@request_method]
        response = @client.http.headers(@headers).public_send(@request_method, @uri.to_s, options_key => @options)
        fail_or_return_response_body(response.code, response, response.headers)
      end

      private

      # 
      # Returns an error if there was one, or parses the fetched object.
      # @param code [Integer] The HTTP response code.
      # @param body [String] The body of the HTTP response.
      # @param headers [Hash] The HTTP response headers.
      # 
      # @return [Array<Hash>, Boolean] The fetched or created parameters or boolean reflecting whether the request was successful.
      def fail_or_return_response_body(code, body, headers)
        error = error(code, body, headers)
        fail(error) if error
        if @request_method == :patch || @request_method == :delete
          true
        else
          symbolize_keys(body.parse)
        end
      end

      # 
      # Generates an error if the code corresponds to one.
      # @param code [Integer] The HTTP response code.
      # @param body [String] The body of the HTTP response.
      # @param headers [Hash] The HTTP response headers.
      # 
      # @return [Glassfrog::Error, nil] The corresponding error, or nil.
      def error(code, body, headers)
        klass = Glassfrog::Error::ERRORS[code]
        klass.from_response(code, body, headers) if !klass.nil?
      end
    end
  end
end