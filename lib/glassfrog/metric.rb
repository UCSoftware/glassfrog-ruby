require 'glassfrog/base'
require 'glassfrog/rest/get'
require 'glassfrog/rest/post'
require 'glassfrog/rest/patch'
require 'glassfrog/rest/delete'

module Glassfrog
  # 
  # Encapsulates GlassFrog Metrics.
  # 
  class Metric < Glassfrog::Base
    # @return [String]
    attr_accessor :description, :frequency, :link, :role_name
    # @return [Boolean]
    attr_accessor :global
    # @return [Hash]
    attr_accessor :links
    PATH = '/metrics'

    # 
    # Sends a GET request for Metric(s) to GlassFrog.
    # @param client [Glassfrog::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassfrog::Base] The options used to find the correct Metrics(s).
    # 
    # @return [Array<Glassfrog::Metric>] The array of Metric(s) fetched from GlassFrog.
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

    # 
    # Sends a POST request to create a Metric on GlassFrog.
    # @param client [Glassforg::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassforg::Base] The options used to create the new Metrics.
    # 
    # @return [Array<Glassfrog::Metric>] The array containing the new Metric.
    def self.post(client, options)
      options = options.is_a?(Glassfrog::Metric) ? options.hashify : options
      response = Glassfrog::REST::Post.post(client, PATH, { metrics: [parse_options(options)] })
      response[:metrics] ? response[:metrics].map { |metric| self.new(metric) } : []
    end

    # 
    # Sends a PATCH request to update a Metric on GlassFrog.
    # @param client [Glassforg::Client] The client that will send the request. Contains the API key.
    # @param identifier [Integer] The ID of the Metric to be updated.
    # @param options [Hash, Glassfrog::Base] The options used to update the Metric.
    # 
    # @return [Boolean] Whether the request failed or not.
    def self.patch(client, identifier, options)
      path = PATH + '/' + identifier.to_s
      options = options.is_a?(Glassfrog::Metric) ? options.hashify : options
      options = Glassfrog::REST::Patch.formify(parse_options(options), self)
      response = Glassfrog::REST::Patch.patch(client, path, options)
    end

    # 
    # Sends a DELETE request to delete a Metric on GlassFrog.
    # @param client [Glassforg::Client] The client that will send the request. Contains the API key.
    # @param options [Hash, Glassfrog::Base] The options containing the ID of the Metric to delete.
    # 
    # @return [Boolean] Whether the request failed or not.
    def self.delete(client, options)
      options = options.is_a?(Glassfrog::Base) ? options.hashify : options
      path = PATH + '/' + options.delete(:id).to_s
      response = Glassfrog::REST::Delete.delete(client, path, options)
    end

    private

    PARAMS = [
      :description,
      :frequency,
      :global,
      :link,
      :circle_id,
      :role_id
    ]

    # 
    # Grabs only the parameters accepted by GlassFrog.
    # @param options [Hash] Inputed options.
    # 
    # @return [Hash] Valid GlassFrog options.
    def self.parse_options(options)
      options[:circle_id] = options[:links][:circle] if options[:links] && options[:links][:circle]
      options[:role_id] = options[:links][:role] if options[:links] && options[:links][:role]
      params_hash = Hash.new
      PARAMS.each { |param| params_hash[param] = options[param] if options[param] }
      params_hash
    end
  end
end