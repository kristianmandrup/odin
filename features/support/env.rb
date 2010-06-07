$LOAD_PATH << File.expand_path('../../../lib', __FILE__)
require 'odin'
require 'rspec'
World(RSpec::Matchers)
