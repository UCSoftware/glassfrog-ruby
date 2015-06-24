require 'glassfrog/rest/request'

module Glassfrog
  module REST
    module Patch
      def self.patch(client, path, options)
        Glassfrog::REST::Request.new(client, :patch, path, options).perform
      end

      def formify(options, type)
        options.keys.map do |key|
         { op: 'replace',
           path: '/' + type + '/0/' + key,
           value: options[key] } 
        end
      end
    end
  end
end