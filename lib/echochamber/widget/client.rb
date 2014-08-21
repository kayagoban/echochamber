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
    # @return [Hash]
    def personalize_widget(widget_id, personalization)
      Echochamber::Request.personalize_widget(token, widget_id, personalization)
    end

    # Enables or Disables a widget
    # 
    # @param widget_id
    # @param status [Echochamber::WidgetStatus]
    # @return [Hash]
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


  end
end

