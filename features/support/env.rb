require 'webmock/rspec'

module WebMockWorld
  include WebMock
  include WebMock::Matchers
end

World(WebMockWorld)
