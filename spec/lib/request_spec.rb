require 'spec_helper'

describe Echochamber::Request do

  let(:app_id)        { "9QCM5C6Y2AX82M" }
  let(:app_secret)    { "390db093ee6f71ffc6d488b9457593a7" }
  let(:api_key)       { "XCNLJFG83URX95Y" }
  let(:email)         { "cthomas@railjumper.com" }
  let(:password)      { "badpassword" }

  let(:credentials) do  
    Echochamber::Credentials.build(app_id, app_secret, api_key, email, password)
  end


  describe '#get_token' do

      it 'returns the accessToken' do
        VCR.use_cassette('get_token', :record => :once) do
          token = Echochamber::Request.get_token(credentials)
          expect(token).to_not be_nil
        end
      end

  end


  describe '#create_user' do

    pending 'calls RestClient.post'

  end

end
