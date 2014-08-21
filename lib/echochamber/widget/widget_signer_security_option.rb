module Echochamber
  class WidgetSignerSecurityOption < Hash

    include Validatable

    # Initialization object
    # 
    # @param [Hash] params SYMBOL-referenced Hash containing: 
    # @option params [String] :authenticationMethod ['INHERITED_FROM_DOCUMENT' or 'KBA' or 'PASSWORD' or 'WEB_IDENTITY' or 'PHONE' or 'NONE']: The authentication method for the recipients to have access to view and sign the widget. PHONE authentication is only applicable to counter signers but not to widget signer
    # @option params [String] :password The password required for the recipient to view and sign the widget
    # @option params [Array] :phoneInfos Populated with instances of [Echochamber::PhoneInfo] The phoneInfo required for the counter signer to view and sign the widget if authentication method is PHONE. Not applicable to widget signer
    def initialize(params)
      require_keys([:authenticationMethod], params)
      merge!(params)
    end

  end
end
