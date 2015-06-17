module Glassfrog
  class Client
    attr_accessor :api_key
    attr_reader :caching, :unrelenting

    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end

    def api_key?
      !!(api_key)
    end
  end
end