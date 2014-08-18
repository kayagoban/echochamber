require 'spec_helper'

require 'echochamber/validatable'

describe Echochamber::Validatable do

  let(:first_name)  { "John" }
  let(:last_name)   { "Public" }

  let(:params) do
    {
      firstName:   first_name,
      lastName:    last_name,
      phone:       "885551234" 
    }
  end

  let(:validatable_object) do
    class Foo 
      include Echochamber::Validatable  
    end
    Foo.new
  end 

  describe ".require_keys" do

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
          validatable_object.require_keys(required_fields, params)
        end.to raise_error(Echochamber::RequiredParameterError)
      end
    end

    context "when field is empty" do
      let(:first_name) { '' }

      it "raises an invalid parameter error" do
        expect do 
          validatable_object.require_keys(required_fields, params)
        end.to raise_error(Echochamber::RequiredParameterError)
      end

    end

    context "when key is not present" do

      it "raises an invalid parameter error" do
        expect do 
          validatable_object.require_keys([:unknown_field], params)
        end.to raise_error(Echochamber::RequiredParameterError)
      end
    end

  end

end
