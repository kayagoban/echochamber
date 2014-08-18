module Echochamber
  module Credentials

    class CredentialsError < StandardError; end
    # Builds a Credentials object
    #
    # @param app_id [String] Application key
    # @param app_secret [String] Application secret
    # @param api_key [String] API Key
    # @param email [String] User email 
    # @param password [String] User password
    # @return [Echochamber::Credentials] Echosign credentials
    def self.build(app_id, app_secret, api_key, email, password)

      # TODO sanity checks on credentials inputs
      #raise CredentialsError, "App key and secret strings must be supplied" if blank?(key) || blank?(secret)
      {
        applicationCredentials:  {
        applicationId: app_id,
        applicationSecret: app_secret
      },
        userCredentials: {
        apiKey: api_key,
        email: email,
        password: password 
      }
      }
    end

    private

    # If blank? did not exist, we would need to invent it.
    def blank?(field)
      field.nil? || field.empty? 
    end

  end
end

