module Echochamber
  class RecipientSecurityOption < Hash

    include Validatable

    # Validates RecipientSecurityOption parameters
    #
    # @param [Hash] params SYMBOL-referenced Hash.
    # @option params [String] :authenticationMethod ['INHERITED_FROM_DOCUMENT' or 'KBA' or 'PASSWORD' or 'WEB_IDENTITY' or 'PHONE' or 'NONE']: The authentication method for the recipients to have access to view and sign the document. (REQUIRED)
    # @option params [Array] :phoneInfos The phoneInfo required for the recipient to view and sign the document.  Populate with instances of [Echochamber::PhoneInfo]
    # @option params [String] :password The password required for the recipient to view and sign the document.
    # @return [Echochamber::RecipientSecurityOption]

    def initialize(params)
      require_keys([:authenticationMethod], params)
      merge! params
    end

  end
end
