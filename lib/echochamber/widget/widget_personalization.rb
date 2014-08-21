module Echochamber
  class WidgetPersonalization < Hash

    include Validatable

    # Initialization object
    # 
    # @option params [String] :email (string): The email address of the person who will be receiving this widget (REQUIRED)
    # expiration (date, optional): Expiration date for the personalization of this widget. After this date, the identity of the signer will not be assumed by EchoSign.,
    # @option params [String] :expiration Expiration date for the personalization of this widget. After this date, the identity of the signer will not be assumed by EchoSign. 
    # @option params [String] :comment Comment describing how the API caller established the signer's identity - will appear in the audit trail.
    # @option params [Boolean] :reusable Should the intended signer be allowed to sign this widget more than once
    # @option params [Boolean] :allowManualVerification Not used at this time,
    # @return [Echochamber::Validatable]
    def initialize(params)
      require_keys([:email], params)
      merge!(params)
    end

  end
end
