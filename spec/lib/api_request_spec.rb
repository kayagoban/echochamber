require 'spec_helper'
#require 'lib/api_request'

describe Echochamber::ApiRequest do

  describe '.initialize' do
    let(:key) { nil }
    let(:secret) { nil }
    it 'rejects nil credentials' do
      expect {Echochamber::ApiRequest.new(key, secret)}.to raise_error(Echochamber::AUTH_CREDENTIALS_ERROR)
    end

    let(:key) { '' }
    let(:secret) { '' }
    it 'rejects empty credentials' do
      expect {Echochamber::ApiRequest.new(key, secret)}.to raise_error(Echochamber::AUTH_CREDENTIALS_ERROR)
    end



  end

  describe '.create_user' do
    pending 'is populated with new user data' do
    end
  end

end


