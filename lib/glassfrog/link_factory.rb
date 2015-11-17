require 'glassfrog/accountability'
require 'glassfrog/domain'
require 'glassfrog/person'

module Glassfrog
  class LinkFactory
    CONFIG = {
      accountabilities: Accountability,
      domains: Domain,
      people: Person
    }

    def self.build(link_type, attributes)
      klass = CONFIG[link_type]
      klass.new(attributes)
    end
  end
end

