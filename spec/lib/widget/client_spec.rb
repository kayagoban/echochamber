require 'spec_helper'

describe Echochamber::Client do
  include_context "shared client"

  describe '.create_widget' do

    let(:url_file_info_params) do
      {
        url: 'http://findgoplayers.com/resume.pdf',
        mimeType: 'application/pdf',
        name: 'resume.pdf'
      }
    end

    let(:file_info_params) do
      { 
        documentURL: Echochamber::UrlFileInfo.new(url_file_info_params) 
      }
    end

    let(:widget_params) do
      {
        signatureFlow: 'SENDER_SIGNS_LAST',
        fileInfos: [ Echochamber::Fileinfo.new(file_info_params) ],
        name: 'Test widget'
      }
    end 

    let(:widget) { Echochamber::Widget.new(nil, nil, widget_params) }

    it 'returns widget info' do
      VCR.use_cassette('create_widget', :record => :once) do
        widget_response = client.create_widget(widget)
        expect(widget_response).to be_a Hash
      end
    end
  end

  describe '.personalize_widget' do
    let(:widget_id) { "2AAABLblqZhD_6RpgbZh5ZVlLXz1H1kfVzw4vHB91MtmjNHBDorFqO0H3_cGzBudZxiWNzPXFzOc*" }
    let(:personalization_params) do
      {
        email: "cthomas@railjumper.com"
      }
    end
    let(:personalization) { Echochamber::WidgetPersonalization.new(personalization_params) }

    it 'returns widget info' do
      VCR.use_cassette('personalize_widget', :record => :once) do
        widget_response = client.personalize_widget(widget_id, personalization)
        expect(widget_response).to be_a Hash
      end
    end
  end

  describe '.update_widget_status' do
    let(:widget_id) { "2AAABLblqZhD_6RpgbZh5ZVlLXz1H1kfVzw4vHB91MtmjNHBDorFqO0H3_cGzBudZxiWNzPXFzOc*" }
    let(:status_params) do
      {
        value: 'ENABLE',
        message: 'Hey guys, hope you like this widget.'
      }
    end
    let(:status) { Echochamber::WidgetStatus.new(status_params) }

    it 'returns widget info' do
      VCR.use_cassette('update_widget_status', :record => :once) do
        widget_response = client.update_widget_status(widget_id, status)
        expect(widget_response).to be_a Hash
      end
    end
  end

  describe '.get_widgets' do
    it 'returns widgets info' do
      VCR.use_cassette('get_widgets', :record => :once) do
        widget_response = client.get_widgets
        expect(widget_response).to be_a Hash
      end
    end
  end

  describe '.get_widget' do
    let(:widget_id) { "2AAABLblqZhD_6RpgbZh5ZVlLXz1H1kfVzw4vHB91MtmjNHBDorFqO0H3_cGzBudZxiWNzPXFzOc*" }
    it 'returns widget info' do
      VCR.use_cassette('get_widget', :record => :once) do
        widget_response = client.get_widget(widget_id)
        expect(widget_response).to be_a Hash
      end
    end
  end

  describe '.get_widget_documents' do
    let(:widget_id) { "2AAABLblqZhD_6RpgbZh5ZVlLXz1H1kfVzw4vHB91MtmjNHBDorFqO0H3_cGzBudZxiWNzPXFzOc*" }

    it 'returns widget documents info' do
      VCR.use_cassette('get_widget_documents', :record => :once) do
        widget_response = client.get_widget_documents(widget_id)
        expect(widget_response).to be_a Hash
      end
    end
  end

  describe '.get_widget_documents' do
    let(:widget_id) { "2AAABLblqZhD_6RpgbZh5ZVlLXz1H1kfVzw4vHB91MtmjNHBDorFqO0H3_cGzBudZxiWNzPXFzOc*" }
    let(:document_id) { "2AAABLblqZhCGyGn1bpbXp-Kt-QXX8fsBWhjjO-bUKd0NQ184Xxm-mE6gg0DN0e-3k0Lwj6IPw9Q*" }

    it 'returns widget document file' do
      VCR.use_cassette('get_widget_document_file', :record => :once) do
        widget_response = client.get_widget_document_file(widget_id, document_id)
        expect(widget_response).to_not be_nil
      end
    end
  end

#  describe '.get_widget_audit_trail' do
#    let(:widget_id) { "2AAABLblqZhD_6RpgbZh5ZVlLXz1H1kfVzw4vHB91MtmjNHBDorFqO0H3_cGzBudZxiWNzPXFzOc*" }

#    it 'returns widget document file' do
#      VCR.use_cassette('get_widget_audit_trail', :record => :once) do
#        widget_response = client.get_widget_audit_trail(widget_id)
#        binding.pry
#        expect(widget_response).to_not be_nil
#      end
#    end
#  end

end
