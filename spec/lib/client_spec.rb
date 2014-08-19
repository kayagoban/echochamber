require 'spec_helper'

describe Echochamber::Client do
  let(:app_id)        { "9QCM5C6Y2AX82M" }
  let(:app_secret)    { "390db093ee6f71ffc6d488b9457593a7" }
  let(:api_key)       { "XCNLJFG83URX95Y" }
  let(:email)         { "cthomas@railjumper.com" }
  let(:password)      { "badpassword" }

  let(:credentials) do  
    Echochamber::Credentials.new(app_id, app_secret, api_key, email, password)
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

    let (:user_params) do
      {
        firstName:  'JohnQ',
        lastName:   'Public',
        email:      'publius@comcast.net',
        password:   'kN12oK9p!3',
        title:      'Hedge Wizard'

      }
    end

    let (:user) { Echochamber::User.new(user_params) }

    it 'returns the User ID' do
      VCR.use_cassette('create_user', :record => :once) do
        user_id = client.create_user(user)
        expect(user_id).to_not be_nil
      end
    end
  end

  describe '.create_agreement' do

    let(:url_file_info) do
      {
      url: 'http://findgoplayers.com/resume.pdf',
      mimeType: 'application/pdf',
      name: 'resume.pdf'
      }
    end

    let(:file_info) do
      { 
        documentURL: Echochamber::UrlFileInfo.new(url_file_info) 
      }
    end

    let(:file_infos) do
      [ Echochamber::Fileinfo.new(file_info) ] 
    end

    let(:agreement_user_id) { nil } 
    let(:agreement_user_email) { nil }

    let(:agreement_info) do
      {
        fileInfos: [ file_infos ],
        recipients: [ Echochamber::Recipient.new({ role: 'SIGNER', email: 'goishi.san@gmail.com'})],
        signatureFlow: "SENDER_SIGNS_LAST",
        signatureType: "ESIGN",
        name: "Rumplestiltskin Contract"
      }
    end

    let(:agreement)  { Echochamber::Agreement.new(agreement_info, agreement_user_id, agreement_user_email) }

    it 'returns the agreement_id' do
      VCR.use_cassette('create_agreement', :record => :once) do
        agreement_id = client.create_agreement(agreement)
        expect(agreement_id).to_not be_nil
      end
    end
  end

  describe '.get_agreements' do
    it 'returns all agreements' do
      VCR.use_cassette('get_agreements', :record => :once) do
        response = client.get_agreements
        expect(response).to_not be_nil
      end
    end
  end

  describe '.agreement_info' do
    let(:agreement_id) { "2AAABLblqZhA79nM-6ALjW2nXMKKb_ECz-Nr2yr_WrJ-3-Vz7d5D5_Dn9B6K-25C_EDktQqawW7M*" }
    it 'returns detailed agreement info' do
      VCR.use_cassette('agreement_info', :record => :once) do
        response = client.agreement_info(agreement_id)
        expect(response).to_not be_nil
      end
    end
  end

  describe '.cancel_agreement' do
    let(:agreement_id) { "2AAABLblqZhA79nM-6ALjW2nXMKKb_ECz-Nr2yr_WrJ-3-Vz7d5D5_Dn9B6K-25C_EDktQqawW7M*" }

    it 'returns the result of the operation' do
      VCR.use_cassette('cancel_agreement', :record => :once) do
        result = client.cancel_agreement(agreement_id, true, 'Just because')
        expect(result).to_not be_nil
      end
    end
  end



  describe '.create_transient_document' do
    let(:file_name) { 'agreement.pdf' }
    let(:mime_type) { 'application/pdf' }
    let(:file) { File.new("fixtures/agreement.pdf", 'rb') }

    it 'returns the transient document ID' do
      VCR.use_cassette('create_transient_document', :record => :once) do
        tran_doc_id = client.create_transient_document(file_name, mime_type, file)
        expect(tran_doc_id).to_not be_nil
      end
    end
  end



end # describe Echochamber::Client


