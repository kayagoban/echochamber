require 'rest-client'

module Echochamber::Request

  BASE_URL = 'https://secure.echosign.com/api/rest/v2'

  ENDPOINT = { 
    token: BASE_URL + '/auth/tokens',
    user: BASE_URL + '/users',
    agreement: BASE_URL + '/agreements'
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

  # Performs REST create_user operation
  #
  # @param body [Hash] Valid request body
  # @return [String] Valid authentication token
  def self.create_user(body, token)
    response = RestClient.post(
      ENDPOINT.fetch(:user), 
      body.to_json, 
      { :content_type => :json, :accept => :json, 'Access-Token' => token}
    )
    JSON.parse(response.body)
  end

  # Performs REST create_agreement operation
  #
  # @param body [Hash] Valid request body
  # @return [String] Valid authentication token
  def self.create_agreement(body, token, user_id, user_email)
    response = RestClient.post(
      ENDPOINT.fetch(:agreement), 
      body.to_json, 
      { 
        :content_type => :json, 
        :accept => :json, 
        'Access-Token' => token,
        'x-user-id' => user_id,
        'x-user-email' => user_email
      }
    )
    JSON.parse(response.body)
  end


end

