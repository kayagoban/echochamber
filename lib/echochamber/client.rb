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
    def create_user(params)
      Echochamber::Validatable.require([:firstName, :lastName, :email, :password], params)
      user = Echochamber::Request.create_user(params, token)
      user.fetch("userId")
    end

    # Creates a user for the current application
    #
    # @param [String] user_id ID of the user whom this agreement is made for
    # @param [String] user_email Email of the user whom this agreement is made for
    # @param [Hash] params SYMBOL-referenced Hash containing:
    # @option params [Array] :fileInfos A list of one or more files (or references to files) that will be sent out for signature. If more than one file is provided, they will be combined into one PDF before being sent out. Note: Only one of the four parameters in every FileInfo object must be specified.  Populate the array from members created by Echochamber::Agreement::Fileinfo.build Echochamber::Agreement::Fileinfo.build (REQUIRED)
    # @option params [Array] :recipients A list of one or more recipients. For regular (non-MegaSign) documents, there is no limit on the number of electronic signatures in a single document. Written signatures are limited to four per document. This limit includes the sender if the sender's signature is also required.  Populate the array from members created by Echochamber::Agreement::Recipient.build (REQUIRED)
    # @option params [String] :signatureFlow ['SENDER_SIGNATURE_NOT_REQUIRED' or 'SENDER_SIGNS_LAST' or 'SENDER_SIGNS_FIRST' or 'SEQUENTIAL' or 'PARALLEL']: Selects the workflow you would like to use - whether the sender needs to sign before the recipient, after the recipient, or not at all. The possible values for this variable are SENDER_SIGNATURE_NOT_REQUIRED, SENDER_SIGNS_LAST, SENDER_SIGNS_FIRST, SEQUENTIAL or PARALLEL.  (REQUIRED)
    # @option params [String] :signatureType ['ESIGN' or 'WRITTEN']: Specifies the type of signature you would like to request - written or eSignature. The possible values are ESIGN or WRITTEN  (REQUIRED)
    # @option params [String] :name The name of the agreement that will be used to identify it, in emails and on the website. (REQUIRED)
    # @return [String] Agreement ID
    def create_agreement(user_id, user_email, params)
      Echochamber::Validatable.require([:signatureType, :recipients, :signatureFlow, :fileInfos, :name], params)
      agreement = Echochamber::Request.create_agreement(params, token, user_id, user_email)
    end

  end # class Client 

end # module Echochamber
