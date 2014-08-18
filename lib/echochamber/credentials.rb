module Echochamber
  class Credentials < Hash

    include Validatable

    # Builds a Credentials object
    #
    # @param app_id [String] Application key
    # @param app_secret [String] Application secret
    # @param api_key [String] API Key
    # @param email [String] User email 
    # @param password [String] User password
    # @return [Echochamber::Credentials] Echosign credentials
    def initialize(app_id, app_secret, api_key, email, password)

      merge!(
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
      )
    end

  end
end

