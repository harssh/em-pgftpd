# coding: utf-8
require "./PgFTPDriver"
require "rubygems"
require "bundler"
require 'webmock/rspec'
Bundler.setup

require 'em-ftpd'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f }

# RSpec.configure do |config|
# #  config.include ReaderSpecHelper
# # Gives you 'use_vcr_cassette' as a macro
# config.extend VCR::RSpec::Macros
# end



