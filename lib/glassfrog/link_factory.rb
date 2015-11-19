module Glassfrog
  class LinkFactory
    @@config = {}

    def self.register(key, klass)
      @@config[key] = klass
    end

    def self.build(link_type, attributes)
      klass = @@config[link_type]
      klass.new(attributes)
    end
  end
end

