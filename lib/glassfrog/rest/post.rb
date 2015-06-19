require 'json'
require 'glassfrog/rest/request'

module Glassfrog
  module REST
    module Post
      def self.post(client, path, options)
        Glassfrog::REST::Request.new(client, :post, path, options).perform
      end
    end
  end
end