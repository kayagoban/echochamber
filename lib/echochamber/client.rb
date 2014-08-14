module Echochamber

 class Client 
    # Initializes the ApiRequest object
    #
    # @param key [String] Application key
    # @param secret [String] Application secret
    # @return [Echochamber::ApiRequest] Initialized ApiRequest
    def initialize(key, secret)
      raise AUTH_CREDENTIALS_ERROR, "App key and secret strings must be supplied" if blank?(key) || blank?(secret)

      @app_key = key
      @secret = secret
    end

    # Creates a user for the current application
    #
    # @param email [String] User's email address
    # @param password [String] The new user's password
    # @param firstName [String] The first name of the new user
    # @param lastName [String] The last name of the new user
    # @param options [Hash] String-referenced Hash containing optional fields:
    # @option options [String] :optIn 'YES' or 'NO' or 'UNKNOWN': Whether or not the user has opted in to recieve marketing information from EchoSign and its partners. Default value is UNKNOWN
    # @option options [String] :groupId Group in which the new user should be added. It can be obtained through GET /users call. Default is Group of the user making this call. The user is inferred from the access_token header
    # @option options [String] :title The new user's job title
    # @option options  [String] :phone The phone number of the new user
    # @option options   [String] :email The email address of the new user
    # @option options  [String] :company The name of the new user's company
    # @option options [String] :customField1 You can choose to use custom fields to record additional information about your new users. These fields are, however, available only with customized implementations - please contact EchoSign if you would like to make use of this functionality
    # @option options  [String] :customField2 You can choose to use custom fields to record additional information about your new users. These fields are, however, available only with customized implementations - please contact EchoSign if you would like to make use of this functionality
    # @option options  [String] :customField3 You can choose to use custom fields to record additional information about your new users. These fields are, however, available only with customized implementations - please contact EchoSign if you would like to make use of this functionality
   def create_user(email, password, firstName, lastName, options={})
     raise REQUIRED_PARAMS_ERROR, "All required fields must be supplied" if any_blank?([email, password, firstName, lastName])
     request_body = {
       "email" => email,
       "password" => password,
       "firstName" => firstName,
       "lastName" => lastName
     }

     request_body.merge!(options)

   end



   private

   # Blanket blank All The Things
   def any_blank?(fields)
      fields.any? do |field|
        blank?(field)
      end
   end

   # If blank? did not exist, we would need to invent it.
   def blank?(field)
     field.nil? || field.empty? 
   end

  end # class ApiRequest

end # module Echochamber
