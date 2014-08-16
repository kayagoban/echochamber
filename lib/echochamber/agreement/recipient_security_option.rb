module Echochamber
  module Agreement
    module RecipientSecurityOption

      # Validates RecipientSecurityOption parameters
      #
      # @param params [Hash] SYMBOL-referenced Hash.
      # @option authenticationMethod [String] ['INHERITED_FROM_DOCUMENT' or 'KBA' or 'PASSWORD' or 'WEB_IDENTITY' or 'PHONE' or 'NONE']: The authentication method for the recipients to have access to view and sign the document. (REQUIRED)
      # @option phoneInfos [Array] The phoneInfo required for the recipient to view and sign the document.  Populate with members created with Echochamber::Agreement::PhoneInfo.build
      # @option password [String] The password required for the recipient to view and sign the document.

      def build(params)
        # TODO validations.

      end

    end
  end
end

