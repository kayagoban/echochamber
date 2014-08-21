module Echochamber::Request

  # Retrieves library documents for a user.
  #
  # @param token [String] Auth Token
  # @param user_id [String] The ID of the user whose library documents are being requested. 
  # @param user_email [String] The email address of the user whose library documents are being requested. If both user_id and user_email are provided then user_id is given preference. If neither is specified then the user is inferred from the access token.
  # @return [Hash] Library documents metadata
  def self.get_library_documents(token, user_id=nil, user_email=nil)
    headers = { 'Access-Token' => token }
    headers.merge!('X-User-Id' => user_id) unless user_id.nil?
    headers.merge!('X-User-Email' => user_email) unless user_email.nil?
    endpoint = ENDPOINT.fetch(:libraryDocument)
    response = get(endpoint, headers)
    JSON.parse(response)
  end

  # Retrieves library document metadata for a user.
  #
  # @param token [String] Auth Token
  # @param library_document_id [String]
  # @return [Hash] Library document metadata
  def self.get_library_document(token, library_document_id)
    headers = { 'Access-Token' => token }
    endpoint = "#{ENDPOINT.fetch(:libraryDocument)}/#{library_document_id}"
    response = get(endpoint, headers)
    JSON.parse(response)
  end

  # Retrieves library document file
  #
  # @param token [String] Auth Token
  # @param library_document_id [String] (REQUIRED)
  # @return [Hash] Library document files metadata
  def self.get_library_document_files(token, library_document_id)
    headers = { 'Access-Token' => token }
    endpoint = "#{ENDPOINT.fetch(:libraryDocument)}/#{library_document_id}/documents"
    response = get(endpoint, headers)
    JSON.parse(response)
  end

  # Retrieves library document file data
  #
  # @param token [String] Auth Token
  # @param library_document_id [String] (REQUIRED)
  # @param file_id [String] (REQUIRED)
  # @return [String] Library document file data
  def self.get_library_document_file(token, library_document_id, file_id)
    headers = { 'Access-Token' => token }
    endpoint = "#{ENDPOINT.fetch(:libraryDocument)}/#{library_document_id}/documents/#{file_id}"
    response = get(endpoint, headers)
  end

  # Retrieves library document file data
  #
  # @param token [String] Auth Token
  # @param library_document_id [String] (REQUIRED)
  # @return [String] Library document file data
  def self.library_document_audit_trail(token, library_document_id)
    headers = { 'Access-Token' => token }
    endpoint = "#{ENDPOINT.fetch(:libraryDocument)}/#{library_document_id}/auditTrail"
    response = get(endpoint, headers)
  end

  # Retrieves library combined document file
  #
  # @param token [String] Auth Token
  # @param library_document_id [String] (REQUIRED)
  # @return [String] Raw library combined document file data
  def self.library_combined_document(token, library_document_id, auditReport)
    headers = { 'Access-Token' => token }
    endpoint = "#{ENDPOINT.fetch(:libraryDocument)}/#{library_document_id}/combinedDocument"
    endpoint << add_query(endpoint, "auditReport=#{auditReport}") 
    response = get(endpoint, headers)
  end

end

