module Echochamber

  class Client 

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

    # Retrieves library document audit trail file
    #
    # @param library_document_id (REQUIRED)
    # @param file_path [String] File path for saving the document.  If none is given, nothing will be saved to disk.
    # @return [String] Raw library document file data
    def library_document_audit_trail(library_document_id, file_path=nil)
      response = Echochamber::Request.library_document_audit_trail(token, library_document_id)
      unless file_path.nil?
        file = File.new(file_path, 'wb')
        file.write(response)
        file.close
      end
      response
    end

    # Retrieves library combined document file
    #
    # @param library_document_id (REQUIRED)
    # @param file_path [String] File path for saving the document.  If none is given, nothing will be saved to disk.
    # @param auditReport [Boolean] When set to YES attach an audit report to the library document PDF. Default value will be false.
    # @return [String] Raw library combined document file data
    def library_combined_document(library_document_id, file_path=nil, auditReport=false)
      response = Echochamber::Request.library_combined_document(token, library_document_id, auditReport)
      unless file_path.nil?
        file = File.new(file_path, 'wb')
        file.write(response)
        file.close
      end
      response
    end




  end
end


