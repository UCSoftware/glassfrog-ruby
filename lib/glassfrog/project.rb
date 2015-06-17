module Glassfrog
  class Project
    attr_accessor :id, :description, :status, :link, :value, :effort, :roi, 
                  :private_to_circle, :created_at, :archived_at, :links

    def initialize(attrs = {})
      attrs.each do |key, value|
        instance_variable_set("@#{key}", value);
      end
      yield(self) if block_given?
    end
  end
end