require 'glassfrog/base'

module Glassfrog
  #
  # Encapsulates GlassFrog Accountability
  #
  class Domain < Glassfrog::Base
    # @return [String]
    attr_accessor :description
  end
end
