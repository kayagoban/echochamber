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
  # @param token [String] Auth Token
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

  # Performs REST GET /agreement/:id operation
  #
  # @param token [String] Auth Token
  # @param agreement_id [String] ID of agreement to retrieve info on.
  # @return [Hash] Agreement info response body
  def self.agreement_info(token, agreement_id)
    headers = { :accept => :json, 'Access-Token' => token }
    endpoint = "#{ENDPOINT.fetch(:agreement)}/#{agreement_id}"

    begin
      response = RestClient.get(
        endpoint, 
        headers
      )
    rescue Exception => error
      raise_error(error)
    end

    JSON.parse(response.body)
  end

  # Performs REST GET /agreement/:id operation
  #
  # @param token [String] Auth Token
  # @param agreement_id [String] ID of agreement to retrieve info on.
  # @return [Hash] Agreement info response body
  def self.agreement_document_file(token, agreement_id, document_id)
    headers = { 'Access-Token' => token }
    endpoint = "#{ENDPOINT.fetch(:agreement)}/#{agreement_id}/#{document_id}"

    binding.pry
    begin
      response = RestClient.get(
        endpoint, 
        headers
      )
    rescue Exception => error
      raise_error(error)
    end

    JSON.parse(response.body)
  end



  # Performs REST GET /agreement/:id/documents
  #
  # @param agreement_id [String] (REQUIRED)
  # @param recipient_email [String] The email address of the participant to be used to retrieve documents. (REQUIRED)
  # @param format [String] Content format of the supported documents. It can have two possible values ORIGINAL or CONVERTED_PDF. (REQUIRED)
  # @param version_id [String] Version of the agreement as provided by {agreement_info agreement_info}.  If not provided, the latest version of the agreement is used.
  # @return [Hash] Agreement documents response body
  def self.agreement_documents(token, agreement_id, recipient_email, format, version_id=nil)
    headers = { :accept => :json, 'Access-Token' => token }
    endpoint = "#{ENDPOINT.fetch(:agreement)}/#{agreement_id}/documents?participantEmail=#{recipient_email}&format=#{format}"
    endpoint << "&version_id=#{version_id}" unless version_id.nil?

    begin
      response = RestClient.get(
        endpoint, 
        headers
      )
    rescue Exception => error
      raise_error(error)
    end

    JSON.parse(response.body)
  end




  # Performs REST PUT /agreement/:id operation
  #
  # @param token [String] Auth Token
  # @param agreement_id [String] ID of agreement to retrieve info on.
  # @param request_body [Hash] Hash for Agreement status update
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


  def self.raise_error(error)
    raise Failure, "#{error.inspect}.  \nSee Adobe Echosign REST API documentation for Error code meanings: https://secure.echosign.com/public/docs/restapi/v2"
  end

end

