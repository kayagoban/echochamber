module Echochamber
  class CounterSignerInfo < Hash

    include Validatable

    # Initialization object
    # 
    # @param [Hash] params SYMBOL-referenced Hash containing: 
    # @option params [String] :email Email of the recipient (REQUIRED)
    # @option params [String] :role ['SIGNER' or 'APPROVER']: Specify the role of recipient (REQUIRED)

    # @option params [Array] :securityOptions Populate with instances of {Echochamber::WidgetSignerSecurityOption Echochamber::WidgetSignerSecurityOption} Security options that apply to the counter signers
    def initialize(params)
      require_keys([:email, :role], params)
      merge!(params)
    end

  end
end
