require 'glassfrog/rest/request'

module Glassfrog
  module REST
    module Patch
      def self.patch(client, path, options)
        Glassfrog::REST::Request.new(client, :patch, path, options).perform
      end

      def self.formify(options, type)
        options.keys.map do |key|
         { op: 'replace',
           path: type::PATH + '/0/' + key.to_s,
           value: options[key] }
        end
      end
    end
  end
end