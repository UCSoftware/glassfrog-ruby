require 'glassfrog/base'
require 'glassfrog/rest/get'

module Glassfrog
  class Circle < Glassfrog::Base
    attr_accessor :name, :short_name, :strategy, :links
    PATH = '/circles'

    def self.get(client, options)
      options = options.is_a?(Glassfrog::Base) ? options.hashify : options
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Get.get(client, path, options)
      response[:circles].map { |circle| self.new(circle) }
    end
  end
end