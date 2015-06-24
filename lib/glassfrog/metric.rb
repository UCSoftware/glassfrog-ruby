require 'glassfrog/base'
require 'glassfrog/rest/get'
require 'glassfrog/rest/post'
require 'glassfrog/rest/patch'
require 'glassfrog/rest/delete'

module Glassfrog
  class Metric < Glassfrog::Base
    attr_accessor :description, :frequency, :global, :links
    PATH = '/metrics'

    def self.get(client, options)
      options = options.is_a?(Glassfrog::Base) ? options.hashify : options
      if options.is_a?(Hash) && options[:id]
        response = Glassfrog::REST::Get.get(client, PATH, {})
        if response[:metrics] then response[:metrics].select! { |metric| metric[:id] == options[:id] } end
      else 
        response = Glassfrog::REST::Get.get(client, PATH, options)
      end
      response[:metrics] ? response[:metrics].map { |metric| self.new(metric) } : []
    end

    def self.post(client, options)
      options = options.is_a? Glassfrog::Metric ? options.hashify : options
      options = { metrics: [ options ] }.to_json
      response = Glassfrog::REST::Post.post(client, PATH, options)
    end

    def self.patch(client, identifier, options)
      path = PATH + '/' + identifier
      options = options.is_a? Glassfrog::Metric ? options.hashify : options
      options = formify(options)
      response = Glassfrog::REST::Patch.patch(client, path, options)
    end

    def self.delete(client, options)
      path = options[:id] ? PATH + '/' + options.delete(:id).to_s : PATH
      response = Glassfrog::REST::Delete.delete(client, path, options)
    end
  end
end