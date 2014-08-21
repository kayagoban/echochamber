RSpec.shared_context "shared client" do

  let(:app_id)        { "9Q444442AX82M" }
  let(:app_secret)    { "390db09fc6672388b9457593a7" }
  let(:api_key)       { "XCFDJKSFLNL5Y" }
  let(:email)         { "nobody@nobody.com" }
  let(:password)      { "password" }

  #let(:email)         { "cthomas@railjumper.com" }
  #let(:password)      { "badpassword" }


  let(:credentials) do  
    Echochamber::Credentials.new(app_id, app_secret, api_key, email, password)
  end

  let(:client) do
    VCR.use_cassette('get_token', :record => :once) do
      Echochamber::Client.new(credentials) 
    end
  end
end
