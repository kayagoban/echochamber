require 'spec_helper'
require 'lib/shared_client.rb'

describe Echochamber::Client do
  include_context "shared client"

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


