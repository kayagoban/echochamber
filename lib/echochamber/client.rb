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

   # Creates a transient document for later referral
   #
   # @param file_name [String] 
   # @param mime_type [String] 
   # @param file [File] 
   # @return [String] Transient document ID
   def create_transient_document(file_name, mime_type, file)
     transient_document_response = Echochamber::Request.create_transient_document(agreement, token, 
                                                                                  transient_document.file_name, 
                                                                                  transient_document.mime_type)
     binding.pry
     transient_document_response.fetch("transientDocumentId")
   end



  end # class Client 

end # module Echochamber
