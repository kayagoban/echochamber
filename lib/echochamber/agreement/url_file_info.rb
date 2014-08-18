module Echochamber
  class UrlFileInfo < Hash

    # Validates UrlFileInfo parameters
    #
    # @param [Hash] :params SYMBOL-referenced Hash 
    # @option params [String] :url A publicly accessible URL for retrieving the raw file content. HTTP authentication is supported using standard embedded syntax - i.e. http://username:password@your.server.com/path/to/file (REQUIRED)
    # @option params [String] :mimeType The mime type of the referenced file, used to determine if the file can be accepted and the necessary conversion steps can be performed.
    # @option params [String] :name The original system file name of the document being sent - used to name attachments, and to infer the mime type if one is not explicitly specified
    def initialize(params)
      require_keys([:url], params)
      merge! params
    end
  end
end

