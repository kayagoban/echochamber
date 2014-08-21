module Echochamber

  class Client

    # Creates a widget and returns the Javascript snippet and URL to access the widget and widgetID in response to the client
    # 
    # @param widget [Echochamber::Widget]
    # @return [Hash]
    def create_widget(widget)
      Echochamber::Request.create_widget(token, widget)
    end

    # Personalize the widget to a signable document for a specific known user
    # 
    # @param widget_id
    # @param personalization [Echochamber::WidgetPersonalization]
    # @return [Hash] Operation result
    def personalize_widget(widget_id, personalization)
      Echochamber::Request.personalize_widget(token, widget_id, personalization)
    end

    # Enables or Disables a widget
    # 
    # @param widget_id
    # @param status [Echochamber::WidgetStatus]
    # @return [Hash] Widget status
    def update_widget_status(widget_id, status)
      Echochamber::Request.update_widget_status(token, widget_id, status)
    end

    # Retrieves widgets for a user
    # 
    # @param user_id [String] The ID of the user whose widgets are being requested
    # @param user_email [String] The email address of the user whose widgets are being requested. If both user_id  and user_email are provided then user_id is given preference. If neither is specified then the user is inferred from the access token
    # @return [Hash] Widgets info
    def get_widgets(user_id=nil, user_email=nil)
      Echochamber::Request.get_widgets(token, user_id, user_email)
    end

    # Retrieves the details of a widget
    # 
    # @param widget_id
    # @return [Hash] Detailed widget info
    def get_widget(widget_id)
      Echochamber::Request.get_widget(token, widget_id)
    end

    # Retrieves the IDs of the documents associated with widget.
    # 
    # @param widget_id [String]
    # @param version_id [String] The version identifier of widget as provided by get_widget. If not provided then latest version will be used.
    # @param participant_email [String] The email address of the participant to be used to retrieve documents
    # @return [Hash] Info about widget documents
    def get_widget_documents(widget_id, version_id=nil, participant_email=nil)
      Echochamber::Request.get_widget_documents(token, widget_id, version_id, participant_email)
    end

    # Retrieves the file stream of a document of a widget
    # 
    # @param widget_id [String]
    # @param document_id [String]
    # @param file_path [String] File path where to save the document.  If none is given, nothing will be saved to file.
    # @return [String] Raw file stream
    def get_widget_document_file(widget_id, document_id, file_path=nil)
      response = Echochamber::Request.get_widget_document_file(token, widget_id, document_id)
      unless file_path.nil?
        file = File.new(file_path, 'wb')
        file.write(response)
        file.close
      end
      response
    end

    # Retrieves the audit trail of a widget identified by widgetId
    # 
    # @note SEEMINGLY NOT YET IMPLEMENTED SERVER-SIDE
    # @param widget_id [String]
    # @param file_path [String] File path where to save the document.  If none is given, nothing will be saved to file.
    # @return [String] Raw file stream
    def get_widget_audit_trail(widget_id, file_path=nil)
      response = Echochamber::Request.get_widget_audit_trail(token, widget_id)
      unless file_path.nil?
        file = File.new(file_path, 'wb')
        file.write(response)
        file.close
      end
      response
    end

    # Gets a single combined PDF document for the documents associated with a widget.
    # 
    # @note SEEMINGLY NOT YET IMPLEMENTED SERVER-SIDE
    # @param widget_id [String]
    # @param file_path [String] File path where to save the document.  If none is given, nothing will be saved to file.
    # @return [String] Raw file stream
    def get_widget_combined_pdf(widget_id, file_path=nil)
      response = Echochamber::Request.get_widget_combined_pdf(token, widget_id)
      unless file_path.nil?
        file = File.new(file_path, 'wb')
        file.write(response)
        file.close
      end
      response
    end

    # Retrieves data entered by the user into interactive form fields at the time they signed the widget
    # 
    # @note SEEMINGLY NOT YET IMPLEMENTED SERVER-SIDE
    # @param widget_id [String]
    # @param file_path [String] File path where to save the document.  If none is given, nothing will be saved to file.
    # @return [String] Raw file stream
    def get_widget_form_data(widget_id, file_path=nil)
      response = Echochamber::Request.get_widget_form_data(token, widget_id)
      unless file_path.nil?
        file = File.new(file_path, 'wb')
        file.write(response)
        file.close
      end
      response
    end




  end
end

