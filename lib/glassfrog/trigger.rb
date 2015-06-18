require 'glassfrog/base'
require 'glassfrog/rest/get'

module Glassfrog
  class Trigger < Glassfrog::Base
    attr_accessor :description, :private_to_circle, :created_at, :links
    PATH = '/triggers'

    def self.get(client, options)
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Get.get(client, path, options)
    end
  end
end