require 'echochamber/agreement/client'

module Echochamber

  class Client 

    attr_reader :token
    # Initializes the Client object
    #
    # @param credentials [Echochamber::Credentials] Initialized Echochamber::Credentials
    # @return [Echochamber::Client] Initialized Echochamber::Client 
    def initialize(credentials)
      @token = Echochamber::Request.get_token(credentials)
    end

    # Creates a user for the current application
    #
    # @param user [Echochamber::User]
    # @return [String] User ID of new Echosign user
    def create_user(user)
      user_response  = Echochamber::Request.create_user(user, token)
      user_response.fetch("userId")
    end

    # Creates a reminder 
    #
    # @param reminder [Echochamber::Reminder]
    # @return [String] Reminder ID
    def create_reminder(reminder)
      reminder_response = Echochamber::Request.create_reminder(token, reminder)
    end

    # Creates a transient document for later referral
    #
    # @param file_name [String] 
    # @param mime_type [String] 
    # @param file_handle [File] 
    # @return [String] Transient document ID
    def create_transient_document(file_name, mime_type, file_handle)
      transient_document_response = Echochamber::Request.create_transient_document(token, file_name, file_handle, mime_type)
      transient_document_response.fetch("transientDocumentId")
    end

    # Retrieve a PDF audit file for an agreement
    #
    # @param agreement_id [String]  (REQUIRED)
    # @param file_path [String] File path to save the document.  If no file path is given, nothing is saved to disk.
    # @return [String] Raw bytes from document file
    def audit_trail_pdf(agreement_id, file_path=nil)
      response = Echochamber::Request.audit_trail_pdf(token, agreement_id)
      unless file_path.nil?
        file = File.new(file_path, 'wb')
        file.write(response)
        file.close
      end
      response
    end


    # Gets all the users in an account that the caller has permissions to access.
    # 
    # @param user_email [String] The email address of the user whose details are being requested  (REQUIRED)
    # @return [Hash] User info hash
    def get_users(user_email)
      Echochamber::Request.get_users(token, user_email)
    end

    # Gets all the users in an account that the caller has permissions to access.
    # 
    # @param user_id [String]
    # @return [Hash] User info hash
    def get_user(user_id)
      Echochamber::Request.get_user(token, user_id)
    end

    # Retrieves library documents metadata for a user.
    #
    # @param user_id [String] The ID of the user whose library documents are being requested. 
    # @param user_email [String] The email address of the user whose library documents are being requested. If both user_id and user_email are provided then user_id is given preference. If neither is specified then the user is inferred from the access token.
    # @return [Hash] Library documents metadata
    def get_library_documents(user_id=nil, user_email=nil)
      Echochamber::Request.get_library_documents(token, user_id, user_email)
    end

    # Retrieves library document metadata 
    #
    # @param library_document_id [String] (REQUIRED)
    # @return [Hash] Library document metadata
    def get_library_document(library_document_id)
      Echochamber::Request.get_library_document(token, library_document_id)
    end

    # Retrieves library document files metadata
    #
    # @param library_document_id [String] (REQUIRED)
    # @return [Hash] Library document files metadata
    def get_library_document_files(library_document_id)
      Echochamber::Request.get_library_document_files(token, library_document_id)
    end

    # Retrieves library document file data
    #
    # @param library_document_id (REQUIRED)
    # @param file_id [String] (REQUIRED)
    # @param file_path [String] File path for saving the document.  If none is given, nothing will be saved to disk.
    # @return [String] Raw library document file data
    def get_library_document_file(library_document_id, file_id, file_path=nil)
      response = Echochamber::Request.get_library_document_file(token, library_document_id, file_id)
      unless file_path.nil?
        file = File.new(file_path, 'wb')
        file.write(response)
        file.close
      end
      response
    end


  end # class Client 

end # module Echochamber
