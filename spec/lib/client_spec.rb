require 'spec_helper'

describe Echochamber::Client do

  let(:file_infos) do
    [
      Echochamber::Agreement::Fileinfo.build( {} )
    ]
  end

  let(:agreement_user_id) { '2AAABLblqZhA4djJBQ5Nlm-I_AWFlCrEQzXmu3k56lHy9h_-EHuFNZCLNplBXRh_FifTL8QlbnOY*' }
  let(:agreement_user_email) { 'publius@comcast.net' }

  let(:agreement_info) do
    {
      fileInfos: [ Echochamber::Agreement::Fileinfo.build({ transientDocumentId: "123" }) ],
      recipients: [ Echochamber::Agreement::Recipient.build({ role: 'SIGNER', email: 'goof@duper.com'})],
      signatureFlow: "SENDER_SIGNS_LAST",
      signatureType: "ESIGN",
      name: "Rumplestiltskin Contract"
    }
  end

  let(:app_id)        { "9QCM5C6Y2AX82M" }
  let(:app_secret)    { "390db093ee6f71ffc6d488b9457593a7" }
  let(:api_key)       { "XCNLJFG83URX95Y" }
  let(:email)         { "cthomas@railjumper.com" }
  let(:password)      { "badpassword" }

  let(:credentials) do  
    Echochamber::Credentials.build(app_id, app_secret, api_key, email, password)
  end

  let (:user_params) do
    {
      firstName:  'JohnQ',
      lastName:   'Public',
      email:      'publius@comcast.net',
      password:   'kN12oK9p!3',
      title:      'Hedge Wizard'

    }
  end

  let(:client) do
    VCR.use_cassette('get_token', :record => :once) do
      Echochamber::Client.new(credentials) 
    end
  end


  describe '#initialize' do
    pending 'calls Echochamber::Request.get_token with credentials'
  end

  describe '.create_user' do
    it 'returns the User ID' do
      VCR.use_cassette('create_user', :record => :once) do
        user_id = client.create_user(user_params)
        expect(user_id).to_not be_nil
      end
    end
  end

  describe '.create_agreement' do
    it 'returns something' do
      #VCR.use_cassette('create_agreement', :record => :once) do
        user_id = client.create_agreement(agreement_user_id, agreement_user_email, agreement_info)
        expect(user_id).to_not be_nil
      #end
    end
  end


end # describe Echochamber::Client


