module Glassfrog
  class Metric
    attr_accessor :id, :description, :frequency, :global, :links

    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end
  end
end