module Echochamber
  class Widget < Hash

    include Validatable

    # Widget initialization object
    # 
    # @param [Hash] params SYMBOL-referenced Hash containing:
    # @option params [String] :passwordProtection Specifies if signers are required to enter a password to have access to sign the widget. The possible values are NONE, EXTERNAL_USERS, INTERNAL_USERS, or ALL_USERS
    # @option params [String] :kbaProtection Signers need to pass Knowledge Based Authentication before they gain access to view and sign the widget. The possible values are NONE, EXTERNAL_USERS, INTERNAL_USERS, or ALL_USERS
    # @option params [String] :webIdentityProtection Specifies if signers are required to provide their web identity, before they gain access to view and sign the widget. The possible values are NONE, EXTERNAL_USERS, INTERNAL_USERS, or ALL_USERS 
    # @option params [Boolean] :protectOpen If set to true, the document is always be encrypted with this password every time it is sent by email. Recipients need to provide the password to be able to view the PDF files
    # @option params [String] :internalPassword The secondary password that will be used to protect signing the widget for internal signers. Note that EchoSign will never show this password to anyone, so you will need to separately communicate it to any relevant parties. This password is applied only if password protection is specified for internal signers or all signers
    # @option params [String] :externalPassword The secondary password that will be used to protect signing the widget for external signers. Note that EchoSign will never show this password to anyone, so you will need to separately communicate it to any relevant parties. This password is applied only if password protection is specified for external signers or all signers
    # @option params [String] :openPassword The secondary password that will be used to secure the PDF document. Note that EchoSign will never show this password to anyone, so you will need to separately communicate it to any relevant parties. This password is used only if protectOpen field is set to true
    def initialize(params)
      merge!(params)
    end

  end
end

