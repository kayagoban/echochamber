module Echochamber
  class WidgetStatus< Hash

    include Validatable

    # Status object 
    # 
    # @option [Hash] params
    # @option params [String] :value The status to which the widget is to be updated. The possible values for this variable are ENABLE and DISABLE (REQUIRED)
    # @option params [String] :message Display this custom message to the user when the widget is accessed. Note that this can contain wiki markup to include clickable links in the message. This is required if redirectUrl is not provided. Both message and redirectUrl can not be specified
    # @option params [String] :redirectUrl Redirect the user to this URL when the widget is accessed. This is required if message is not provided. Both message and redirectUrl can not be specified
    # @return [Echochamber::WidgetStatus]
    def initialize(params)
      require_keys([:value], params)
      require_exactly_one([:message, :redirectUrl], params)
      merge!(params)
    end

  end
end
