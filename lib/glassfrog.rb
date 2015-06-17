require "glassfrog/version"

require "glassfrog/get"
require "glassfrog/post"
require "glassfrog/patch"
require "glassfrog/delete"

require "httparty"

module Glassfrog
  include HTTParty

  @@root_uri = 'https://glassfrog.holacracy.org/api/v3/'

  class Client
    
  end
end