require 'rest-client'

module Echochamber::Request

  class Failure < StandardError; end

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
    begin
      response = RestClient.post(ENDPOINT[:token], credentials.to_json, :content_type => :json, :accept => :json)
    rescue RestClient::BadRequest => error
      raise_error(error)
    end

    response_body = JSON.parse(response.body)
    response_body.fetch("accessToken")
  end

  # Performs REST create_user operation
  #
  # @param body [Hash] Valid request body
  # @return [String] Valid authentication token
  def self.create_user(body, token)
    begin
      response = RestClient.post(
        ENDPOINT.fetch(:user), 
        body.to_json, 
        { :content_type => :json, :accept => :json, 'Access-Token' => token}
      )
    rescue RestClient::BadRequest => error
      raise_error(error)
    end

    JSON.parse(response.body)
  end

  # Performs REST create_agreement operation
  #
  # @param body [Hash] Valid request body
  # @return [String] Valid authentication token
  def self.create_agreement(body, token, user_id, user_email)
    begin
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
    rescue RestClient::BadRequest => error
      raise_error(error)
    end

    JSON.parse(response.body)
  end

  def self.raise_error(error)
    raise Failure, "#{error.inspect}.  \nSee Adobe Echosign REST API documentation for Error code meanings: https://secure.echosign.com/public/docs/restapi/v2"
  end

end

