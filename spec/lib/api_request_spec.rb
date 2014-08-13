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

    let(:key) { 'fakekey' }
    let(:secret) { 'fakesecret' }
    let(:client) { Echochamber::ApiRequest.new(key, secret) }

    let(:user) { '' }
    let(:password) { '' }
    let(:firstname) { '' }
    let(:lastname) { '' }

    it 'rejects empty parameters' do
      expect{ client.create_user(user, password, firstname, lastname) }.to raise_error Echochamber::REQUIRED_PARAMS_ERROR
    end

    let(:user) { nil }
    let(:password) { nil }
    let(:firstname) { nil }
    let(:lastname) { nil }


    it 'rejects nil parameters' do
      expect{ client.create_user(user, password, firstname, lastname) }.to raise_error Echochamber::REQUIRED_PARAMS_ERROR
    end
 
  end

end


