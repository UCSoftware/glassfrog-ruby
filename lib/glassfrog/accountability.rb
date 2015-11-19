require 'glassfrog/base'
require 'glassfrog/link_factory'

module Glassfrog
  #
  # Encapsulates GlassFrog Accountability
  #
  class Accountability < Glassfrog::Base
    # @return [String]
    attr_accessor :description

    LinkFactory.register(:accountabilities, self)
  end
end

