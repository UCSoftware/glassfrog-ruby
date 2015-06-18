require 'glassfrog/rest/request'

module Glassfrog
  module REST
    module Post
      def post(path, options)
        Glassfrog::REST::Request.new(self, :post, path, options)
      end
    end
  end
end