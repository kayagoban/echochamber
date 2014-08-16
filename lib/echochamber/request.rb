require 'rest-client'

module Echochamber::Request

  BASE_URL          = 'https://secure.echosign.com/api/rest/v2'

  ENDPOINT = { 
    token: BASE_URL + '/auth/tokens',
    user: BASE_URL + '/users'
  }

  # Retrieves the authentication token
  #
  # @param credentials [Echochamber::Credentials] Initialized Echochamber::Credentials
  # @return [String] Valid authentication token
  def self.get_token(credentials)
    response = RestClient.post(ENDPOINT[:token], credentials.to_json, :content_type => :json, :accept => :json)
    response_body = JSON.parse(response.body)
    response_body.fetch("accessToken")
  end

  # Performs REST create operation
  #
  # @param endpoint_key [Symbol] Symbol to resolve the Echochamber::Request::ENDPOINT hash.  Can be one of :tokens, :users, :blah, :blah, :etc
  # @param body [Hash] Valid request body
  # @return [String] Valid authentication token
  def self.create(endpoint_key, body, token)
    response = RestClient.post(
      ENDPOINT.fetch(endpoint_key), 
      body.to_json, 
      { :content_type => :json, :accept => :json, 'Access-Token' => token}
    )
    JSON.parse(response.body)
  end


end

