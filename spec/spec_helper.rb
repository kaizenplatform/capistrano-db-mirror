require 'rubygems'
require 'simplecov'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

SimpleCov.start do
    add_filter 'spec/'
end

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each {|f| require f }

RSpec.configure do |config|
end
