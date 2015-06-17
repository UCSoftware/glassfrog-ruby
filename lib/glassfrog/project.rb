module Glassfrog
  class Project
    attr_accessor :id, :description, :status, :link, :value, :effort, :roi, 
                  :private_to_circle, :created_at, :archived_at, :links

    def initialize(attrs = {})
      
    end
  end
end