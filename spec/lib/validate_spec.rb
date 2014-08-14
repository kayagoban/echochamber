require 'spec_helper'

describe Echochamber::Validate do

  describe "#user" do

    let(:first_name)   { "John" }
    let(:last_name)    { "Public" }
    let(:password)     { "password_on_the_sticky_note" }
    let(:email)        { "johnqpublic@comcast.net" }
    let(:phone)        { "885551234" }

    let(:user) do
      {
        first_name: first_name,
        last_name:  last_name,
        email:      email,
        password:   password,
        phone:      phone
      }
    end
    let(:validation) { Echochamber::Validate.user(user) }

    context "when it has no first name" do
      let(:first_name) { '' }

      it "raises an invalid credential error" do
        expect{validation}.to raise_error(Echochamber::InvalidCredentialError)
      end
    end

    context "when it has no password" do
      let(:password) { '' }

      it "raises an invalid credential error" do
        expect{validation}.to raise_error(Echochamber::InvalidCredentialError)
      end
    end

    context "when it has no last name" do
      let(:last_name) { '' }

      it "raises an invalid credential error" do
        expect{validation}.to raise_error(Echochamber::InvalidCredentialError)
      end
    end

    context "when it has no email" do
      let(:email) { '' }

      it "raises an invalid credential error" do
        expect{validation}.to raise_error(Echochamber::InvalidCredentialError)
      end
    end

  end

end
