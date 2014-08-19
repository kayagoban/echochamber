require 'rest-client'

module Echochamber::Request

  class Failure < StandardError; end

  BASE_URL = 'https://secure.echosign.com/api/rest/v2'

  ENDPOINT = { 
    token: BASE_URL + '/auth/tokens',
    user: BASE_URL + '/users',
    agreement: BASE_URL + '/agreements',
    transientDocument: BASE_URL + '/transientDocuments'
  }

  # Retrieves the authentication token
  #
  # @param credentials [Echochamber::Credentials] Initialized Echochamber::Credentials
  # @return [String] Valid authentication token
  def self.get_token(credentials)
    begin
      response = RestClient.post(ENDPOINT[:token], credentials.to_json, :content_type => :json, :accept => :json)
    rescue Exception => error
      raise_error(error)
    end

    response_body = JSON.parse(response.body)
    response_body.fetch("accessToken")
  end

  # Performs REST create_user operation
  #
  # @param body [Hash] Valid request body
  # @return [Hash] New user response body
  def self.create_user(body, token)
    begin
      response = RestClient.post(
        ENDPOINT.fetch(:user), 
        body.to_json, 
        { :content_type => :json, :accept => :json, 'Access-Token' => token}
      )
    rescue Exception => error
      raise_error(error)
    end

    JSON.parse(response.body)
  end

  # Performs REST create_agreement operation
  #
  # @param body [Hash] Request body  (REQUIRED)
  # @param token [String] Auth token  (REQUIRED)
  # @param user_id [String] Echosign user ID  (REQUIRED)
  # @param user_email [String] Echosign user email
  # @return [Hash] Agreement response body
  def self.create_agreement(body, token, user_id=nil, user_email=nil)
    headers = { :content_type => :json, :accept => :json, 'Access-Token' => token }
    headers.merge!('X-User-Id' => user_id) unless user_id.nil?
    headers.merge!('X-User-Email' => user_email) unless user_email.nil?

    begin
      response = RestClient.post(
        ENDPOINT.fetch(:agreement), 
        body.to_json, 
        headers 
      )
    rescue Exception => error
      raise_error(error)
    end

    JSON.parse(response.body)
  end

  # Performs REST GET /agreements operation
  #
  # @return [Hash] Agreements response body
  def self.get_agreements(token)
    headers = { :accept => :json, 'Access-Token' => token }

    begin
      response = RestClient.get(
        ENDPOINT.fetch(:agreement), headers
      )
    rescue Exception => error
      raise_error(error)
    end

    JSON.parse(response.body)
  end

  # Performs REST PUT /agreement/:id operation
  #
  # @return [Hash] Agreements response body
  def self.update_agreement_status(token, agreement_id, request_body)
    headers = { :content_type => :json, :accept => :json, 'Access-Token' => token }
    endpoint = "#{ENDPOINT.fetch(:agreement)}/#{agreement_id}/status"
    begin
      response = RestClient.put(
        endpoint, 
        request_body.to_json,
        headers
      )
    rescue Exception => error
      raise_error(error)
    end

    JSON.parse(response.body)
  end

  # Performs REST create_transient_document operation
  #
  # @param token [String] Auth token  (REQUIRED)
  # @param file_name [String] File name  (REQUIRED)
  # @param mime_type [String] Mime type
  # @return [Hash] Transient Document Response Body
  def self.create_transient_document(token, file_name, file_handle, mime_type=nil)
    headers = { :content_type => :json, :accept => :json, 'Access-Token' => token }
    #headers.merge!('File-Name' => file_name) 
    #headers.merge!('Mime-Type' => mime_type) unless mime_type.nil?

    begin
    response =  RestClient.post ENDPOINT.fetch(:transientDocument), {'File-Name' => file_name, 'Mime-Type' => mime_type, 'File' => file_handle,  :multipart => true}, headers
    #  response = RestClient.post(
    #    ENDPOINT.fetch(:transientDocument), 
    #    body.to_json, 
    #    headers 
    #  )
    rescue Exception => error
      raise_error(error)
    end

    JSON.parse(response.body)
  end


  def self.raise_error(error)
    raise Failure, "#{error.inspect}.  \nSee Adobe Echosign REST API documentation for Error code meanings: https://secure.echosign.com/public/docs/restapi/v2"
  end

end

