require "glassfrog/version"

require "httparty"

module Glassfrog
  include HTTParty

  @@root_uri = 'https://glassfrog.holacracy.org/api/v3/'

end
