module Echochamber
  module Agreement
    module UrlFileInfo 

      # Validates UrlFileInfo parameters
      #
      # @param params [Hash] SYMBOL-referenced Hash 
      # @option url [String] A publicly accessible URL for retrieving the raw file content. HTTP authentication is supported using standard embedded syntax - i.e. http://username:password@your.server.com/path/to/file (REQUIRED)
      # @option mimeType [String] The mime type of the referenced file, used to determine if the file can be accepted and the necessary conversion steps can be performed.
      # @option name [String]  The original system file name of the document being sent - used to name attachments, and to infer the mime type if one is not explicitly specified
      def build(params)

        # TODO validation goes here!
        params
      end
    end
  end
end

