require 'rspec/expectations'
require 'pg'
require './PgFTPDriver.rb'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

