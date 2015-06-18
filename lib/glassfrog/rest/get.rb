require 'glassfrog/rest/request'

module Glassfrog
  module REST
    module Get
      def self.get(client, path, options)
        Glassfrog::REST::Request.new(client, :get, path, options).perform
      end
    end
  end
end