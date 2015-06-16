module Get
  attr_accessor :client

  class Request
    def initialize(cache)
      @cache, @stack = cache, []
    end
    def method_missing(meth, *args, &blk)
      
    end
  end
end