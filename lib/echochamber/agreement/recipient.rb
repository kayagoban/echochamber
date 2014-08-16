module Echochamber
  module Agreement
    module Recipient

      # Validates Recipient parameters
      #
      # @param params [Hash] SYMBOL-referenced Hash.  Role, and either fax or email is required.
      # @option role [String] ['SIGNER' or 'APPROVER']: Specify the role of recipient (REQUIRED)
      # @option email [String] Email of the recipient. This is required if fax is not provided. Both fax and email can not be provided (email or fax REQUIRED)
      # @option fax [String] Fax of the recipient. This is required if email is not provided. Both fax and email can not be provided (email or fax REQUIRED)
      # @option securityOptions [Array] Security options that apply to the recipient.  Populate the array with members from the results of Echochamber::Agreement::RecipientSecurityOption.build

      def build(params)
        # TODO validations.  either email or fax is required

      end

    end
  end
end

