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

   # Creates an agreement
   #
   # @param agreement [Echochamber::Agreement]
   # @return [String] Agreement ID
   def create_agreement(agreement)
     agreement_response = Echochamber::Request.create_agreement(agreement, token, agreement.user_id, agreement.user_email)
     agreement_response.fetch("agreementId")
   end

   # Gets list of agreements
   #
   # @param agreement [Echochamber::Agreement]
   # @return [String] Agreement ID
   def get_agreements
     get_agreements_response = Echochamber::Request.get_agreements(token)
     get_agreements_response.fetch("userAgreementList")
   end

   # Gets detailed info on an agreement
   # 
   # @param agreement_id [String] ID of agreement to retrieve info on.
   # @return [Hash] Detailed agreement info
   def agreement_info(agreement_id)
     Echochamber::Request.agreement_info(token, agreement_id)
   end

   # Cancel agreement
   # 
   # @param agreement_id [String] (REQUIRED)
   # @param notify_signer [Boolean] Whether to notify the signer by email of the cancellation.  Default is false.
   # @param comment [String] Comment regarding this cancellation.
   # @return [String] Result of the operation
   def cancel_agreement(agreement_id, notify_signer=false, comment=nil)
     request_body = {
       "value" => "CANCEL",
       "notifySigner" => notify_signer 
     }
     request_body.merge!(comment: comment) unless comment.nil?

     agreement_status_response = Echochamber::Request.update_agreement_status(token, agreement_id, request_body)
     agreement_status_response.fetch('result')
   end

   # All documents relating to an agreement
   # 
   # @param agreement_id [String] (REQUIRED)
   # @param recipient_email [String] The email address of the participant to be used to retrieve documents. (REQUIRED)
   # @param format [String] Content format of the supported documents. It can have two possible values ORIGINAL or CONVERTED_PDF. (REQUIRED)
   # @param version_id [String] Version of the agreement as provided by agreement_info().  If not provided, the latest version of the agreement is used.
   # @return [Array] Documents relating to agreement.
   def agreement_documents(agreement_id, recipient_email, format, version_id=nil)
     result = Echochamber::Request.agreement_documents(token, agreement_id, recipient_email, format, version_id)
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

   # Retrieve a document file from an agreement
   #
   # @param agreement_id [String]  (REQUIRED)
   # @param document_id [String]  (REQUIRED)
   # @param file_path [String] File path to save the document.  If no file path is given, nothing is saved to disk.
   # @return [String] Raw bytes from document file
   def agreement_document_file(agreement_id, document_id, file_path=nil)
     response = Echochamber::Request.agreement_document_file(token, agreement_id, document_id)
     unless file_path.nil?
       file = File.new(file_path, 'wb')
       file.write(response)
       file.close
     end
     response
   end



  end # class Client 

end # module Echochamber
