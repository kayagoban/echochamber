require 'rest-client'
require 'echochamber/agreement/request'

module Echochamber::Request

  class Failure < StandardError; end

  BASE_URL = 'https://secure.echosign.com/api/rest/v2'

  ENDPOINT = { 
    token: BASE_URL + '/auth/tokens',
    user: BASE_URL + '/users',
    agreement: BASE_URL + '/agreements',
    reminder: BASE_URL + '/reminders',
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
  # @param token [String] Auth Token
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
  
  # Sends a reminder for an agreement.
  #
  # @param body [Hash] Valid request body
  # @param token [String] Auth Token
  # @return [Hash] Response body
  def self.create_reminder(token, body)
    begin
      response = RestClient.post(
        ENDPOINT.fetch(:reminder), 
        body.to_json, 
        { :content_type => :json, :accept => :json, 'Access-Token' => token}
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
  # @param file_handle [File] File handle (REQUIRED)
  # @param mime_type [String] Mime type
  # @return [Hash] Transient Document Response Body
  def self.create_transient_document(token, file_name, file_handle, mime_type=nil)
    headers = { :content_type => :json, :accept => :json, 'Access-Token' => token }

    begin
      response = RestClient.post( 
                                 ENDPOINT.fetch(:transientDocument), 
                                 { 'File-Name' => file_name, 
                                   'Mime-Type' => mime_type, 
                                   'File' => file_handle,  
                                   :multipart => true}, 
                                   headers
                                )
    rescue Exception => error
      raise_error(error)
    end

    JSON.parse(response.body)
  end

  # Gets all the users in an account that the caller has permissions to access. 
  #
  # @param token [String] Auth Token
  # @param user_email [String] The email address of the user whose details are being requested.
  # @return [Hash] User info hash
  def self.get_users(token, user_email)
    headers = { 'Access-Token' => token }
    endpoint = "#{ENDPOINT.fetch(:user)}?x-user-email=#{user_email}"

    begin
      response = RestClient.get(
        endpoint, 
        headers
      )
    rescue Exception => error
      raise_error(error)
    end

    JSON.parse(response)
  end

  # Gets all the users in an account that the caller has permissions to access. 
  #
  # @param token [String] Auth Token
  # @param user_id [String]
  # @return [Hash] User info hash
  def self.get_user(token, user_id)
    headers = { 'Access-Token' => token }
    endpoint = "#{ENDPOINT.fetch(:user)}/#{user_id}"

    begin
      response = RestClient.get(
        endpoint, 
        headers
      )
    rescue Exception => error
      raise_error(error)
    end

    JSON.parse(response)
  end



  def self.raise_error(error)
    raise Failure, "#{error.inspect}.  \nSee Adobe Echosign REST API documentation for Error code meanings: https://secure.echosign.com/public/docs/restapi/v2"
  end

end

