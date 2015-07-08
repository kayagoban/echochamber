require 'syck'
require 'bundler/setup'
require 'webmock/rspec'
require 'vcr'
require 'factory_girl'
require 'echochamber'
require 'pry'
 
Bundler.setup

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |config|
  config.include WebMock
  config.include FactoryGirl::Syntax::Methods
end


