require 'glassfrog/rest/request'

module Glassfrog
  module REST
    module Patch
      def patch(path, options)
        Glassfrog::REST::Request.new(self, :patch, path, options)
      end
    end
  end
end