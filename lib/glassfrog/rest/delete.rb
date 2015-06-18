require 'glassfrog/rest/request'

module Glassfrog
  module REST
    module Delete
      def self.delete(client, path, options)
        Glassfrog::REST::Request.new(client, :delete, path, options)
      end
    end
  end
end