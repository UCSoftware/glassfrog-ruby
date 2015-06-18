module Glassfrog
  class Error < StandardError
    attr_reader :code

    # Raised with a 4xx HTTP status code
    ClientError = Class.new(self)

    # Raised with the HTTP status code 400
    BadRequest = Class.new(ClientError)

    # Raised with the HTTP status code 401
    Unauthorized = Class.new(ClientError)

    # Raised with the HTTP status code 403
    Forbidden = Class.new(ClientError)

    # Raised with the HTTP status code 404
    NotFound = Class.new(ClientError)

    # Raised with the HTTP status code 406
    NotAcceptable = Class.new(ClientError)

    # Raised with the HTTP status code 422
    UnprocessableEntity = Class.new(ClientError)

    # Raised with the HTTP status code 429
    TooManyRequests = Class.new(ClientError)

    # Raised with a 5xx HTTP status code
    ServerError = Class.new(self)

    # Raised with the HTTP status code 500
    InternalServerError = Class.new(ServerError)

    # Raised with the HTTP status code 502
    BadGateway = Class.new(ServerError)

    # Raised with the HTTP status code 503
    ServiceUnavailable = Class.new(ServerError)

    # Raised with the HTTP status code 504
    GatewayTimeout = Class.new(ServerError)

    ERRORS = {
      400 => Glassfrog::Error::BadRequest,
      401 => Glassfrog::Error::Unauthorized,
      403 => Glassfrog::Error::Forbidden,
      404 => Glassfrog::Error::NotFound,
      406 => Glassfrog::Error::NotAcceptable,
      422 => Glassfrog::Error::UnprocessableEntity,
      429 => Glassfrog::Error::TooManyRequests,
      500 => Glassfrog::Error::InternalServerError,
      502 => Glassfrog::Error::BadGateway,
      503 => Glassfrog::Error::ServiceUnavailable,
      504 => Glassfrog::Error::GatewayTimeout,
    }

    class << self
      def from_response(code, body, headers)
        message = parse_error(code, body, headers)
        new(message, code)
      end

      private

      def parse_error(code, body, headers)
        if body.content_type['mime_type'] == 'application/json' && body.parse['message']
          body.parse['message']
        elsif body.content_type['mime_type'] == 'text/html' && headers['Status']
          headers['Status']
        else 
          code
        end
      end
    end

    def initialize(message = '', code = nil)
      super(message)
      @code = code
    end
  end
end