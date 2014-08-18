module Echochamber
  class User < Hash

    include Validatable

    # Creates a user for the current application
    #
    # @options [Hash] params SYMBOL-referenced Hash containing:
    # @option params [String] :email User's email address (REQUIRED)
    # @option params [String] :password The new user's password (REQUIRED)
    # @option params [String] :firstName The first name of the new user (REQUIRED)
    # @option params [String] :lastName The last name of the new user (REQUIRED)
    # @option params [String] :optIn 'YES' or 'NO' or 'UNKNOWN': Whether or not the user has opted in to recieve marketing information from EchoSign and its partners. Default value is UNKNOWN
    # @option params options [String] :groupId Group in which the new user should be added. It can be obtained through GET /users call. Default is Group of the user making this call. The user is inferred from the access_token header
    # @option params [String] :title The new user's job title
    # @option params [String] :phone The phone number of the new user
    # @option params [String] :company The name of the new user's company
    # @option params [String] :customField1 You can choose to use custom fields to record additional information about your new users. These fields are, however, available only with customized implementations - please contact EchoSign if you would like to make use of this functionality
    # @option params [String] :customField2 You can choose to use custom fields to record additional information about your new users. These fields are, however, available only with customized implementations - please contact EchoSign if you would like to make use of this functionality
    # @option params [String] :customField3 You can choose to use custom fields to record additional information about your new users. These fields are, however, available only with customized implementations - please contact EchoSign if you would like to make use of this functionality
    # @return [String] User ID
    def initialize(params)
      require_keys([:firstName, :lastName, :email, :password], params)
      merge(params)
    end

  end # class User
end # module Echochamber
