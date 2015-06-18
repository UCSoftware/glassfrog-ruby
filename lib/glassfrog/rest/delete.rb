require 'glassfrog/rest/request'

module Glassfrog
  module REST
    module Delete
      def delete(path, options)
        Glassfrog::REST::Request.new(self, :delete, path, options)
      end
    end
  end
end