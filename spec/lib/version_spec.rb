require 'spec_helper'

describe Echochamber do
  it 'returns a version string' do
    expect(Echochamber::VERSION).to be_a String 
  end
end
