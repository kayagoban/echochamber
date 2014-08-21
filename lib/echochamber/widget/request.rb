module Echochamber::Request

  # Creates a widget and returns the Javascript snippet and URL to access the widget and widgetID in response to the client
  # 
  # @param token [String] Auth token
  # @param widget [Echochamber::Widget]
  # @return [Hash]
  def self.create_widget(token, widget)
    endpoint = ENDPOINT.fetch(:widget) 
    headers = { :content_type => :json, :accept => :json, 'Access-Token' => token}
    headers.merge!('X-User-Id' => widget.user_id) unless widget.user_id.nil?
    headers.merge!('X-User-Email' => widget.user_email) unless widget.user_email.nil?
    response = post(endpoint, widget, headers)
    JSON.parse(response.body)
  end

end
