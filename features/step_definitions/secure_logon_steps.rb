require 'ftpfxp'

Given /^a user tries to connect with secure environment$/ do
  @ftp = Net::FTPFXPTLS.new('localhost')
 # @ftp = Net::FTPFXPTLS.connect
end


Then /^the user should see an secure log in success message$/ do
   @ftp.last_response_code.should match("\n")
end