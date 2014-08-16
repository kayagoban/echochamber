require 'bundler/setup'
require 'webmock/rspec'
require 'vcr'
require 'echochamber'
require 'pry'
 
Bundler.setup

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end

RSpec.configure do |config|
  config.include WebMock
end


