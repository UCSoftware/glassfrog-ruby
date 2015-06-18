require 'glassfrog/rest/request'

module Glassfrog
  module REST
    module Get
      def get(path, options)
        Glassfrog::REST::Request.new(self, :get, path, options)
      end
    end
  end
end