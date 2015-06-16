module Get
  attr_writer :client

  class Request
    def initialize(cache)
      @cache = cache
    end
    def method_missing(meth, *args, &blk)
      
    end
  end
end