require 'spec_helper'

describe Echochamber::Client do
  include_context "shared client"

  describe '.get_library_documents' do
    let(:user_id) { nil }
    let(:user_email) { 'cthomas@railjumper.com' }
    it 'returns info about library documents' do
      VCR.use_cassette('get_library_documents', :record => :once) do
        response = client.get_library_documents(user_id, user_email)
        expect(response).to be_a Hash
      end
    end
  end

  describe '.get_library_document' do
    let(:library_document_id) {"2AAABLblqZhCri9FNiCHjwsixnFegzTxO6cP52B-FIhfOXZjjDHggZoYPQB5r0YS66QZg4DLQV-g*"}
    it 'returns info about library document' do
      VCR.use_cassette('get_library_document', :record => :once) do
        response = client.get_library_document(library_document_id)
        expect(response).to be_a Hash
      end
    end
  end

  describe '.get_library_document_files' do
    let(:library_document_id) {"2AAABLblqZhAlC4t0c3xAJ92RFv44xFGZhbCuHpalUdpcHW9k72imMEG-W1SYCmUoia1ZNgQZ-FE*"}
    it 'returns info about library document files' do
      VCR.use_cassette('get_library_document_file', :record => :once) do
        response = client.get_library_document_files(library_document_id)
        expect(response).to be_a Hash
      end
    end
  end

  describe '.get_library_document_file' do
    let(:library_document_id) { "2AAABLblqZhAlC4t0c3xAJ92RFv44xFGZhbCuHpalUdpcHW9k72imMEG-W1SYCmUoia1ZNgQZ-FE*" }
    let(:file_id) { "2AAABLblqZhD0YJu7EaQ3t2aKYe74spEGcgIXHeloWBdhkceuEbfqs9cw0pdkFB6z3RR4N8OWkZg*" }
    it 'returns library document file data' do
      VCR.use_cassette('get_library_document_data', :record => :once) do
        response = client.get_library_document_file(library_document_id, file_id)
        expect(response).to_not be_nil 
      end
    end
  end

  describe '.library_document_audit_trail' do
    let(:library_document_id) { "2AAABLblqZhAlC4t0c3xAJ92RFv44xFGZhbCuHpalUdpcHW9k72imMEG-W1SYCmUoia1ZNgQZ-FE*" }
    it 'returns library document file data' do
      VCR.use_cassette('library_document_audit_trail', :record => :once) do
        response = client.library_document_audit_trail(library_document_id)
        expect(response).to_not be_nil 
      end
    end
  end

  describe '.library_combined_document' do
    let(:library_document_id) { "2AAABLblqZhAlC4t0c3xAJ92RFv44xFGZhbCuHpalUdpcHW9k72imMEG-W1SYCmUoia1ZNgQZ-FE*" }
    it 'returns library combined document file data' do
      VCR.use_cassette('library_combined_document', :record => :once) do
        response = client.library_combined_document(library_document_id, nil, true)
        expect(response).to_not be_nil 
      end
    end
  end



end

