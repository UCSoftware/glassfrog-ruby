module Post
  attr_writer :client

  class Request
    def initialize
    end
    def method_missing(meth, *args, &blk)
      
    end
  end
end