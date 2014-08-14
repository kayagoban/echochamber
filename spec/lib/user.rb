require 'spec_helper'

describe Echochamber::User do

  let(:user) { Echochamber::User.new(user_params) }
  let(:user_params) do
    {
      first_name: first_name,
      last_name:  last_name,
      email:      email,
      password:   password,
      options:    options_hash
    }
  end
  
  let(:first_name)   { "Reginald" }
  let(:last_name)    { "Fartworthington" }
  let(:password)     {  "fartworth" }
  let(:email)        { "rfarting@comcast.net" }
  let(:options_hash) do
    {
      phone: "885551234"
    }
  end

  describe "#initialize" do

    context "when it has no first name" do
      let(:first_name) { '' }
      let(:new_user) { Echochamber.new(user_params) }

      it "raises an invalid credential error" do
        expect(new_user).to raise(Echochamber::InvalidCredentialError)
      end
    end

    context "when it has no first name" do
      let(:first_name) { '' }
      let(:new_user) { Echochamber.new(user_params) }

      it "raises an invalid credential error" do
        expect(new_user).to raise(Echochamber::InvalidCredentialError)
      end
    end

    context "when it has no last name" do
      let(:last_name) { '' }
      let(:new_user) { Echochamber.new(user_params) }

      it "raises an invalid credential error" do
        expect(new_user).to raise(Echochamber::InvalidCredentialError)
      end
    end

    context "when it has no email" do
      let(:email) { '' }
      let(:new_user) { Echochamber.new(user_params) }

      it "raises an invalid credential error" do
        expect(new_user).to raise(Echochamber::InvalidCredentialError)
      end
    end

    context "when it has no password" do
      let(:password) { '' }
      let(:new_user) { Echochamber.new(user_params) }

      it "raises an invalid credential error" do
        expect(new_user).to raise(Echochamber::InvalidCredentialError)
      end
    end

  end

  describe "#to_hash" do

    let(:expected_hash) do
     {
       firstName: first_name,
       lastName:  last_name,
       email:     email,
       password:  password,
     }.merge(options_hash)
    end

    it "returns a valid user hash" do
      options_hash.
      expect(user.to_hash).to eq(expected_hash)
    end
    
  end

end
