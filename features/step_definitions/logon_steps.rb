require './PgFTPDriver.rb'
require 'net/ftp'

    
Given /^a user tries to connect$/ do
    
      @ftp = Net::FTP.new('localhost')
end

When /^the user log in with invalid information$/ do
        
    begin
      @ftp.login('t','0')
    rescue Exception => @e
     
      puts @e
      
    end
    
end

Then /^the user should see an log in error message$/ do
    
      @e.message.should match(/530.+/)      # 530 response when not log in error
     
end

When /^the user logs in$/ do
  
    begin
      
      @ftp.login('12345','12345')
      
    rescue Exception => @e
      puts @e
    end
    
    
end

Then /^the user should see an log in success message$/ do
    
      @ftp.last_response_code.should match("200")    # 200 success response
end



