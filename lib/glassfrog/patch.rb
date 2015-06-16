module Patch
  attr_accessor :client

  class Request
    def initialize
      @stack = []
    end
    def method_missing(meth, *args, &blk)
      
    end
  end
end