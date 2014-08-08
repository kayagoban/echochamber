module Echochamber
  class RequestBody

    # Creates the request body for the user creation API call
    #
    # @param email_address [String] User's email address, REQUIRED FIELD
    # @param password [String] The new user's password, REQUIRED FIELD
    # @param firstName [String] The first name of the new user, REQUIRED FIELD
    # @param lastName [String] The last name of the new user, REQUIRED FIELD
    # @param optIn [String] 'YES' or 'NO' or 'UNKNOWN': Whether or not the user has opted in to recieve marketing information from EchoSign and its partners. Default value is UNKNOWN
    # @param groupId [String] Group in which the new user should be added. It can be obtained through GET /users call. Default is Group of the user making this call. The user is inferred from the access_token header
    # @param title [String] The new user's job title
    # @param phone [String] The phone number of the new user
    # @param email [String] The email address of the new user
    # @param company [String] The name of the new user's company
    # @param customField3 [String] You can choose to use custom fields to record additional information about your new users. These fields are, however, available only with customized implementations - please contact EchoSign if you would like to make use of this functionality
    # @param customField1 [String] You can choose to use custom fields to record additional information about your new users. These fields are, however, available only with customized implementations - please contact EchoSign if you would like to make use of this functionality
    # @param customField2 [String] You can choose to use custom fields to record additional information about your new users. These fields are, however, available only with customized implementations - please contact EchoSign if you would like to make use of this functionality
   def create_user(email_address, password)
      
   end


    def create_user(email, password, firstname, lastname)
        { 
          "email":      email,
          "password":   password,
          "firstName":  firstname,
          "lastName":   lastname 
        }
    end



  end

end
