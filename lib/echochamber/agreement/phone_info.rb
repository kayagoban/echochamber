module Echochamber
  class PhoneInfo < Hash

    include Validatable

    # PhoneInfo 
    #
    # @param [Hash] params SYMBOL-referenced Hash.
    # @option params [String] :phone The phone number required for the recipient to view and sign the document (REQUIRED)
    # @option params [String] :countryCode The phoneInfo country code required for the recipient to view and sign the document if authentication type is PHONE
    # @return [Echochamber::PhoneInfo]

    def initialize(params)
      require_keys([:phone], params)
      merge!(params)
    end

  end
end
