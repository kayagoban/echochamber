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

  describe '.get_users' do
   let(:email) { "cthomas@railjumper.com" }
    it 'returns user data' do
      VCR.use_cassette('get_users', :record => :once) do
        response = client.get_users(email)
        expect(response).to be_a Hash
      end
   end
  end

  describe '.get_user' do
   let(:id) { "2AAABLblqZhBp6sZ412RCo4_5P1OCDATcuKQf3gzb7M-kea77rqC7h6kzMKSpofswP8rY9Cwv9Vw*" }
    it 'returns user data' do
      VCR.use_cassette('get_user', :record => :once) do
        response = client.get_user(id)
        expect(response).to be_a Hash
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
      #  transientDocumentId: "2AAABLblqZhASezqyVioHG5sGiurozjMEAJOXDzoG0ycIeLopOTfcwu0in1uhWU3Pp7hRcf3VOGlFiaFtul6CQubO4vRo-UXIStCJqssVq9b-hI-4Zq10hMnzBtA1W89PTZoCYyU4gGyaZ0_2OjJb38xjAxQQuG7_0CJ0UA9Glw32_zOEj9lzIRmuvkEtD3qOzm2GVvV1mULX7a4IWP5vsvSgvWYADjRcHv_zXIEphMizvHg1nS0uAQ**"
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

    let(:agreement)  { Echochamber::Agreement.new(agreement_user_id, agreement_user_email, agreement_info) }

    it 'returns the agreement_id' do
      VCR.use_cassette('create_agreement', :record => :once) do
        agreement_id = client.create_agreement(agreement)
        expect(agreement_id).to_not be_nil
      end
    end
  end

  describe '.create_reminder' do
    let(:reminderInfo) { { 
        agreementId: "2AAABLblqZhA79nM-6ALjW2nXMKKb_ECz-Nr2yr_WrJ-3-Vz7d5D5_Dn9B6K-25C_EDktQqawW7M*", 
        comment: "Hey don't forget..." 
    } }
    let(:reminder) { Echochamber::Reminder.new(reminderInfo) }

    it 'returns result'  do
      VCR.use_cassette('create_reminder', :record => :once) do
        response = client.create_reminder(reminder)
        expect(response).to be_a Hash
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

  describe '.agreement_form_data' do
   let(:agreement_id) { "2AAABLblqZhDvfdYluvps8mSzQXnXr074OVtMYTwTVtljZYFJNi43iuzYeBaPUUOMTSlGXrt04Sw*" }
    it 'returns CSV data' do
      VCR.use_cassette('agreement_form_data', :record => :once) do
        response = client.agreement_form_data(agreement_id)
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

  describe '.agreement_documents' do
    let(:agreement_id) { "2AAABLblqZhA79nM-6ALjW2nXMKKb_ECz-Nr2yr_WrJ-3-Vz7d5D5_Dn9B6K-25C_EDktQqawW7M*" }
    let(:recipient_email) { 'goishi.san@gmail.com' }
    let(:format) { 'ORIGINAL' }
    let(:version_id) { nil }

    it 'returns information about documents for this agreement' do
      VCR.use_cassette('agreement_documents', :record => :once) do
        result = client.agreement_documents(agreement_id, recipient_email, format, version_id)
        expect(result).to_not be_nil
      end
    end
  end

  describe '.agreement_document_file' do
    let(:agreement_id) { "2AAABLblqZhA79nM-6ALjW2nXMKKb_ECz-Nr2yr_WrJ-3-Vz7d5D5_Dn9B6K-25C_EDktQqawW7M*" }
    let(:document_id) { "2AAABLblqZhDcteEO9jy6gSat9d_3XgpPVpxhetoDCpU4L9PoolGv_3mqgKL1DhIGTXTHhqAHlHk*" }

    it 'returns a document file from the selected agreement' do
      VCR.use_cassette('agreement_document_file', :record => :once) do
        result = client.agreement_document_file(agreement_id, document_id)
        expect(result).to be_a String 
        expect(result).to_not be_nil
      end
    end
  end

  describe '.audit_trail_pdf' do
    let(:agreement_id) { "2AAABLblqZhA79nM-6ALjW2nXMKKb_ECz-Nr2yr_WrJ-3-Vz7d5D5_Dn9B6K-25C_EDktQqawW7M*" }

    it 'returns a pdf file for an audit trail on the agreement' do
      VCR.use_cassette('audit_trail_pdf', :record => :once) do
        result = client.audit_trail_pdf(agreement_id)
        expect(result).to be_a String 
        expect(result).to_not be_nil
      end
    end
  end

  describe '.agreement_combined_pdf' do
    let(:agreement_id) { "2AAABLblqZhA79nM-6ALjW2nXMKKb_ECz-Nr2yr_WrJ-3-Vz7d5D5_Dn9B6K-25C_EDktQqawW7M*" }

    it 'returns a combined pdf file ' do
      VCR.use_cassette('agreement_combined_pdf', :record => :once) do
        result = client.agreement_combined_pdf(agreement_id)
        expect(result).to be_a String 
        expect(result).to_not be_nil
      end
    end
  end

  describe '.agreement_signing_urls' do
    let(:agreement_id) { "2AAABLblqZhDdfTP0uM4EIz2UE2Mq27D7PXGl7Uk3e5nO4RtzlkN8GMANmeVwUVRWGGuUGCQoRQc*" }

    it 'returns URL information for the agreement' do
      VCR.use_cassette('agreement_signing_urls', :record => :once) do
        result = client.agreement_signing_urls(agreement_id)
        expect(result).to be_a Hash
      end
    end
  end

  describe '.create_transient_document' do
    let(:file_name) { 'agreement.pdf' }
    #let(:file_name) { 'fillable.pdf' }
    let(:mime_type) { 'application/pdf' }
    let(:file) { File.new("fixtures/agreement.pdf", 'rb') }
    #let(:file) { File.new("/tmp/fillable.pdf", 'rb') }

    it 'returns the transient document ID' do
      VCR.use_cassette('create_transient_document', :record => :once) do
        tran_doc_id = client.create_transient_document(file_name, mime_type, file)
        expect(tran_doc_id).to_not be_nil
      end
    end
  end



end # describe Echochamber::Client


