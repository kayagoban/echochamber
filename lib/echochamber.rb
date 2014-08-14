require "echochamber/version"
require 'echochamber/api_request'
require 'echochamber/validate'

module Echochamber
  BASE_URL = 'https://secure.echosign.com/api/rest/v2'
  AUTH_ENDPOINT = BASE_URL + '/auth'
  USERS_ENDPOINT = BASE_URL + '/users'
end
