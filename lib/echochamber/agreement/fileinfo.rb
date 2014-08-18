module Echochamber
  class Fileinfo < Hash

    include Validatable

    # Validates Fileinfo params 
    #
    # @param [Hash] params SYMBOL-referenced Hash containing exactly one of the following:
    # @option params [String] :transientDocumentId A transient document ID available to the sender
    # @option params [String] :libraryDocumentId A library document ID available to the sender
    # @option params [String] :libraryDocumentName A library document name available to the sender
    # @option params [Echochamber::UrlFileInfo] :documentURL A description of the URL where the document can be found
    # @return [Echochamber::Fileinfo]
    def initialize(params)
      require_exactly_one([:transientDocumentId, :libraryDocumentId, :libraryDocumentName, :documentURL], params)
      merge!(params)
    end
  end
end

