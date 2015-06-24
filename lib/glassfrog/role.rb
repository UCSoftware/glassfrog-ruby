require 'glassfrog/utils/utils'
require 'glassfrog/base'
require 'glassfrog/rest/get'
require 'glassfrog/rest/patch'

module Glassfrog
  class Role < Glassfrog::Base
    include Glassfrog::Utils
    attr_accessor :name, :purpose, :links
    PATH = '/roles'

    def self.get(client, options)
      options = options.is_a?(Glassfrog::Base) ? options.hashify : options
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Get.get(client, path, options)
      response[:roles].map { |role| self.new(role) }
    end

    def self.patch(client, identifier, options)
      path = PATH + '/' + identifier
      options = options.is_a? Glassfrog::Role ? options.hashify : options
      response = Glassfrog::REST::Patch.patch(client, path, options)
    end

    def name_parameterized
      parameterize(@name)
    end
  end
end