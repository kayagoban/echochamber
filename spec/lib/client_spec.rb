require 'spec_helper'

describe Echochamber::Client do

  let (:user_params) do
    {
      firstName:  'JohnQ',
      lastName:   'Public',
      email:      'john.public@comcast.net',
      password:   'kN12oK9p!3',
      title:      'Hedge Wizard'

    }
  end
  let(:app_id)        { "9QCM5C6Y2AX82M" }
  let(:app_secret)    { "390db093ee6f71ffc6d488b9457593a7" }
  let(:api_key)       { "XCNLJFG83URX95Y" }
  let(:email)         { "cthomas@railjumper.com" }
  let(:password)      { "vvidmk" }

  let(:credentials) do  
    Echochamber::Credentials.build(app_id, app_secret, api_key, email, password)
  end

  let(:client) do
    Echochamber::Client.new(credentials) 
  end
  

  describe '#initialize' do
    it 'returns self' do
      expect(client.token).to_not eq(nil) 
    end
  end

  describe '.create_user' do
    it 'calls validator' do
      #user = client.create_user(user_params)
      #{"userId"=>"2AAABLblqZhAwNIN4aYZD2dn20cHAhVXNpOiRJogUqzE_XvDV_4pSUDOpWAkrFtcQIbdAZGdiLi8*"}
    end
  end

end


