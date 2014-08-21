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
        binding.pry
        expect(widget_response).to be_a Hash
      end
    end

  end

end
