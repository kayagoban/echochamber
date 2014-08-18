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
    # @param [Echochamber::User] Initialized Echochamber::User
    # @option params [String] :email User's email address (REQUIRED)
   def create_user(user)
     user_response  = Echochamber::Request.create_user(user, token)
     user_response.fetch("userId")
   end

   # Creates an agreement
   #
   # @param [Echochamber::Agreement] Initialized Echochamber::Agreement 
   # @return [String] Agreement ID
   def create_agreement(agreement)
     agreement_response = Echochamber::Request.create_agreement(agreement, token, agreement.user_id, agreement.user_email)
     binding.pry
     agreement_response.fetch("agreementId")
   end

  end # class Client 

end # module Echochamber
