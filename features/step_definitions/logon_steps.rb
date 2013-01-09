require './PgFTPDriver.rb'

Given /^a user has an account$/ do
 # pending # express the regexp above with the code you wish you had
 
      @cucumbertest = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  
end

When /^the user tries to log in with invalid information$/ do
 # pending # express the regexp above with the code you wish you had
      @cucumbertest.receive_line("USER 12345")
      @cucumbertest.reset_sent!
      @cucumbertest.receive_line("PASS")
end

Then /^the user should see an log in error message$/ do
  #pending # express the regexp above with the code you wish you had
     @cucumbertest.sent_data.should match(/553.+/)
end

When /^the user logs in$/ do
 # pending # express the regexp above with the code you wish you had
     # @cucumbertest.receive_line("USER 12345")
     # @cucumbertest.reset_sent!
     # @cucumbertest.receive_line("PASS 12345")
     log_in()
end

Then /^the user should see an log in success message$/ do
 # pending # express the regexp above with the code you wish you had
     @cucumbertest.sent_data.should match(/230.+/)
end



private


 def log_in()
   
   @cucumbertest.receive_line("USER 12345")
   @cucumbertest.reset_sent!
   @cucumbertest.receive_line("PASS 12345")
   
   
 end
