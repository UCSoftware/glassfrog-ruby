require "glassfrog/version"

require "glassfrog/get"
require "glassfrog/post"
require "glassfrog/patch"
require "glassfrog/delete"

require "httparty"

module Glassfrog
  include HTTParty

  @@root_uri = 'https://glassfrog.holacracy.org/api/v3/'

  class Client
    attr_reader :key, :cacheEnabled, :persistEnabled

    def initialize(api_key, *options)
      @key, @cacheEnabled, @persistEnabled = 
        api_key, options.include?(:cache), options.include?(:persist)
      Get.client = Post.client = Patch.client = Delete.client = self
    end
    def get(cache)
      Get::Request.new(cache)
    end
    def post
      Post::Request.new
    end
    def patch
      Patch::Request.new
    end
    def delete
      Delete::Request.new
    end
  end
end