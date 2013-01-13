require './PgFTPDriver.rb'
require 'net/ftp'

Before do
  
  # @cucumbertest = EM::FTPD::App.start('./config.rb')  #creating server instance
 
   
end
 
   
Given /^a user tries to connect$/ do
     # pending # express the regexp above with the code you wish you had  
     @ftp = Net::FTP.new('localhost')
     end

When /^the user log in with invalid information$/ do
     #pending # express the regexp above with the code you wish you had
   
   begin
      @ftp.login('t','0')
    rescue Exception => @e
      
    ensure
      
    end
    
end

Then /^the user should see an log in error message$/ do
  #pending # express the regexp above with the code you wish you had
   
     @e.message.should match(/530.+/)
     
end

When /^the user logs in$/ do
   # pending # express the regexp above with the code you wish you had
    
    begin
      
     @ftp.login('t','1')
      
    rescue Exception => @e
      
    ensure
      
    end
    
    
end

Then /^the user should see an log in success message$/ do
#  pending # express the regexp above with the code you wish you had
   # @e.message.should match(/530.+/)
    
    
    
    
    @ftp.last_response_code.should match("200")
end



