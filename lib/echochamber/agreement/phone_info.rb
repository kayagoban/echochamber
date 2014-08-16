module Echochamber
  module Agreement
    module PhoneInfo 

      # Validates PhoneInfo parameters
      #
      # @param params [Hash] SYMBOL-referenced Hash.
      # @option phone [String] The phone number required for the recipient to view and sign the document if authentication type is PHONE (REQUIRED)
      # @option countryCode [String] The phoneInfo country code required for the recipient to view and sign the document if authentication type is PHONE

      def build(params)
        # TODO validations.

      end

    end
  end
end

