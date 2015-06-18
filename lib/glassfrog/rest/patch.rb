require 'glassfrog/rest/request'

module Glassfrog
  module REST
    module Patch
      def self.patch(client, path, options)
        Glassfrog::REST::Request.new(client, :patch, path, options)
      end
    end
  end
end