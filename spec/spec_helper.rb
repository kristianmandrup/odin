require 'bundler'
Bundler.setup(:default, :test)

require 'rspec'
require 'rspec/autorun'
require 'fakefs'
require 'session'
require 'odin'

RSpec.configure do |config|
  config.mock_with :mocha
end

def status_ok
  @status.should be_true      
  @stdout.should be_empty 
  @stdout.should be_empty      
end

def status_not_ok
  @status.should be_false      
  @stdout.should_not be_empty 
  @stdout.should_not be_empty      
end
