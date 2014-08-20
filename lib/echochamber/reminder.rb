module Echochamber
  class Reminder < Hash

    include Validatable

    # Reminder options
    #
    # @param [Hash] params SYMBOL-referenced Hash containing exactly one of the following:
    # @option params [String] :agreementId (REQUIRED)
    # @option params [String] :comment An Optional message sent to the recipients, describing what is being sent and why their signatures are required.
    # @return [Echochamber::Reminder]
    def initialize(params)
      require_keys([:agreementId], params)
      merge!(params)
    end
  end
end
