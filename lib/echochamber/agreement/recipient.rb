module Echochamber
  module Agreement
    module Recipient

      # Validates Recipient parameters
      #
      # @param [Hash] params SYMBOL-referenced Hash.  Role, and either fax or email is required.
      # @option params [String] :role ['SIGNER' or 'APPROVER']: Specify the role of recipient (REQUIRED)
      # @option params [String] :email Email of the recipient. This is required if fax is not provided. Both fax and email can not be provided (email or fax REQUIRED)
      # @option params [String] :fax Fax of the recipient. This is required if email is not provided. Both fax and email can not be provided (email or fax REQUIRED)
      # @option params [Array] :securityOptions Security options that apply to the recipient.  Populate the array with members from the results of Echochamber::Agreement::RecipientSecurityOption.build

      def self.build(params)
        Echochamber::Validator.require([:role], params)
        Echochamber::Validator.require_exactly_one([:email, :fax], params)
        params
      end

    end
  end
end

