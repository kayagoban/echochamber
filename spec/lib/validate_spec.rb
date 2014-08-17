require 'spec_helper'

describe Echochamber::Validator do

  describe "#user" do

    let(:first_name)  { "John" }
    let(:last_name)   { "Public" }

    let(:params) do
      {
        firstName:   first_name,
        lastName:    last_name,
        phone:       "885551234" 
      }
    end

    let(:required_fields) do
      [
        :firstName,
        :lastName
      ]
    end


    context "when field is nil" do
      let(:first_name) { nil }

      it "raises an invalid parameter error" do
        expect do 
          Echochamber::Validator.require(required_fields, params)
        end.to raise_error(Echochamber::RequiredParameterError)
      end
    end

    context "when field is empty" do
      let(:first_name) { '' }

      it "raises an invalid parameter error" do
        expect do 
          Echochamber::Validator.require(required_fields, params)
        end.to raise_error(Echochamber::RequiredParameterError)
      end
 
    end

    context "when key is not present" do

      it "raises an invalid parameter error" do
        expect do 
          Echochamber::Validator.require([:unknown_field], params)
        end.to raise_error(Echochamber::RequiredParameterError)
      end
    end

  end

end
