module Echochamber

  class Client 


    attr_reader :token
    # Initializes the Client object
    #
    # @param credentials [Echochamber::Credentials] Initialized Echochamber::Credentials
    # @return [Echochamber::ApiRequest] Initialized Echochamber::Client 
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

   # Creates an agreement
   #
   # @param agreement [Echochamber::Agreement]
   # @return [String] Agreement ID
   def get_agreements
     get_agreements_response = Echochamber::Request.get_agreements(token)
     get_agreements_response.fetch("userAgreementList")
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



  end # class Client 

end # module Echochamber
