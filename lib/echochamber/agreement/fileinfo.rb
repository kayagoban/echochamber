module Echochamber
  module Agreement
    module Fileinfo

      # Validates Fileinfo params 
      #
      # @param params [Hash] SYMBOL-referenced Hash containing only one of the following:
      # @option transientDocumentId [String] A transient document ID available to the sender
      # @option libraryDocumentId [String] A library document ID available to the sender
      # @option libraryDocumentName [String] A library document name available to the sender
      # @option documentURL [Hash] Parameters created by Echochamber::Agreement::UrlFileInfo.build
      def build(params)

        # TODO validation goes here!
        params
      end
    end
  end
end

