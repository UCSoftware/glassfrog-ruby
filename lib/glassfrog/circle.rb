require 'glassfrog/base'
require 'glassfrog/rest/get'

module Glassfrog
  class Circle < Glassfrog::Base
    attr_accessor :name, :short_name, :strategy, :links
    PATH = '/circles'

    def self.get(client, options)
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Get.get(client, path, options)
    end
  end
end