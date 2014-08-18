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

  describe ".validate_field" do

    context "when field is nil" do
      let(:first_name) { nil }

      it "raises an invalid parameter error" do
        expect do 
          validatable_object.validate_field(first_name, params)
        end.to raise_error(Echochamber::RequiredParameterError)
      end
    end

    context "when field is empty" do
      let(:first_name) { '' }

      it "raises an invalid parameter error" do
        expect do 
          validatable_object.validate_field(first_name, params)
        end.to raise_error(Echochamber::RequiredParameterError)
      end

    end

    context "when key is not present" do
      it "raises an invalid parameter error" do
        expect do 
          validatable_object.validate_field([:unknown_field], params)
        end.to raise_error(Echochamber::RequiredParameterError)
      end
    end

  end

  describe '.require_keys' do
    let(:required_fields) do
      [
        :firstName,
        :lastName
      ]
    end

    context 'when all required fields are present' do
      it 'it does not raise an error' do
        expect do 
          validatable_object.require_keys(required_fields, params)
        end.to_not raise_error
      end
    end

    context 'when a required field is not present' do
      it 'it raises an error' do
        expect do 
          validatable_object.require_keys(required_fields.push(:unknown_field), params)
        end.to raise_error(Echochamber::RequiredParameterError)
      end
    end
  end

  describe '.require_exactly_one' do
    context 'when more than one key value is present' do
      it 'it raises an error' do
        expect do 
          validatable_object.require_exactly_one([:firstName, :lastName], params)
        end.to raise_error(Echochamber::ParameterError)
      end
    end

    context 'when none of the key values are present' do
      it 'it raises an error' do
        expect do 
          validatable_object.require_exactly_one([:unknown_field], params)
        end.to raise_error(Echochamber::ParameterError)
      end
    end

    context 'when exactly one of the key values is present' do
      it 'it does not raise an error' do
        expect do 
          validatable_object.require_exactly_one([:firstName], params)
        end.to_not raise_error
      end
    end

  end

end
