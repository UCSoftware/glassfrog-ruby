require 'glassfrog/base'
require 'glassfrog/link_factory'

module Glassfrog
  #
  # Encapsulates GlassFrog Accountability
  #
  class Domain < Glassfrog::Base
    # @return [String]
    attr_accessor :description

    LinkFactory.register(:domains, self)
  end
end
