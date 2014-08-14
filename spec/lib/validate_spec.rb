require 'spec_helper'

describe Echochamber::Validate do

  describe "#user" do

    let(:first_name)  { "John" }
    let(:last_name)   { "Public" }
    let(:password)    { "superhardpassword" }
    let(:email)       { 'john.q.public@comcast.net' }

    let(:user) do
      {
        firstName:   first_name,
        lastName:    last_name,
        email:       email,
        password:    password,
        phone:       "885551234" 
      }
    end

    let(:validation) { Echochamber::Validate.user(user) }

    context "when email is nil " do
      let(:email) { nil }

      it "raises an invalid parameter error" do
        expect{validation}.to raise_error(Echochamber::InvalidParameterError)
      end
    end

    context "when email is empty" do
      let(:email) { '' }

      it "raises an invalid parameter error" do
        expect{validation}.to raise_error(Echochamber::InvalidParameterError)
      end
    end

    context "when email key is not present" do
      let(:email_less_user) do
        no_email = user.dup 
        no_email.delete(:email)
        no_email
      end
      it "raises an invalid parameter error" do
        expect{Echochamber::Validate.user(email_less_user)}.to raise_error(Echochamber::InvalidParameterError)
      end
    end



    context "when it has no password" do
      let(:password) { '' }

      it "raises an invalid parameter error" do
        expect{validation}.to raise_error(Echochamber::InvalidParameterError)
      end
    end

    context "when it has no last name" do
      let(:last_name) { '' }

      it "raises an invalid parameter error" do
        expect{validation}.to raise_error(Echochamber::InvalidParameterError)
      end
    end

    context "when it has no first name" do
      let(:first_name) { '' }

      it "raise an invalid parameter error" do
        expect{validation}.to raise_error(Echochamber::InvalidParameterError)
      end
    end

  end

end
