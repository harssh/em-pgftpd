Given /^user not logged in$/ do
   @cucumbertest = EM::FTPD::Server.new(nil, PgFTPDriver.new)
end

When /^user tries to upload file$/ do
      @cucumbertest.reset_sent!
      @cucumbertest.receive_line("stor")
      
end

Then /^user should get log in error message$/ do
      @cucumbertest.sent_data.should match(/530.+/)
end

When /^user tries to upload without params$/ do
     @cucumbertest.receive_line("STOR")
    
end

When /^user tries to upload with params$/ do
  
      @filename = create_tempfile()
     log_in_pasv()
     @cucumbertest.receive_line("STOR #{@filename} /tmp/#{@filename}")
     
end

Then /^user should get upload success$/ do
      @cucumbertest.sent_data.should match(/150.+200.+/m)
      remove_file_from_db(@filename)
    
end