require "echochamber/version"
require 'echochamber/api_request'
require 'echochamber/user'
require 'echochamber/request_body'

module Echochamber
  BASE_URL = 'https://secure.echosign.com/api/rest/v2'
  AUTH_ENDPOINT = BASE_URL + '/auth'
  USERS_ENDPOINT = BASE_URL + '/users'

  class AUTH_CREDENTIALS_ERROR < StandardError; end
  class REQUIRED_PARAMS_ERROR < StandardError; end

  class InvalidCredentialError < StandardError; end
end
