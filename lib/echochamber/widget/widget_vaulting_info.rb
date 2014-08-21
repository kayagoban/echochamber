module Echochamber
  class WidgetVaultingInfo < Hash

    include Validatable

    # Initialization object
    # 
    # @param [Hash] params SYMBOL-referenced Hash containing: 
    # @option params [Boolean] :enabled For accounts set up for document vaulting and the option to enable per agreement, this determines whether the document is to be vaulted
    def initialize(params)
      require_keys([:enabled], params)
      merge!(params)
    end

  end
end
