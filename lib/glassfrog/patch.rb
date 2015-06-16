module Patch
  attr_writer :client

  def method_missing(meth, *args, &blk)
    
  end  
end