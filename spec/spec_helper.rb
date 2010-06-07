require 'bundler'
Bundler.setup(:default, :test)

require 'rspec'
require 'rspec/autorun'
require 'odin'

RSpec.configure do |config|
  config.mock_with :
end

