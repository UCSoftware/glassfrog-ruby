require "glassfrog/version"

require "httparty"

module Glassfrog
  include HTTParty

  @@root_uri = 'https://glassfrog.holacracy.org/api/v3/'

  class Client

    def initialize(api_key, *options)
      @key, @cacheEnabled, @persistEnabled = 
        api_key, options.include?('cache'), options.include?('persist')
    end

    def get
      
    end

    def post
      
    end

    def patch
      
    end

    def delete
      
    end

  end
end
