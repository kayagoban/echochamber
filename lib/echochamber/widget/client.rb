module Echochamber

  class Client

    # Creates a widget and returns the Javascript snippet and URL to access the widget and widgetID in response to the client
    # 
    # @param widget [Echochamber::Widget]
    # @return [Hash]
    def create_widget(widget)
      response = Echochamber::Request.create_widget(token, widget)
    end

  end
end

