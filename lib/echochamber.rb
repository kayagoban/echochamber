require "echochamber/version"
require 'echochamber/client'
require 'echochamber/validate'

module Echochamber
  BASE_URL = 'https://secure.echosign.com/api/rest/v2'
  AUTH_ENDPOINT = BASE_URL + '/auth'
  USERS_ENDPOINT = BASE_URL + '/users'
end
