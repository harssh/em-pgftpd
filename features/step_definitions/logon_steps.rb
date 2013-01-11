require './PgFTPDriver.rb'

Before do
  
   @cucumbertest = EM::FTPD::App.start('./config.rb')  #creating server instance
 
end
 
   
Given /^a user has an account$/ do
      pending # express the regexp above with the code you wish you had  
     
     end

When /^the user tries to log in with invalid information$/ do
 pending # express the regexp above with the code you wish you had
      
end

Then /^the user should see an log in error message$/ do
  pending # express the regexp above with the code you wish you had
 
      
end

When /^the user logs in$/ do
  pending # express the regexp above with the code you wish you had
    
end

Then /^the user should see an log in success message$/ do
  pending # express the regexp above with the code you wish you had
    
end



private


 def log_in()
   
   @cucumbertest.receive_line("USER 12345")
   @cucumbertest.reset_sent!
   @cucumbertest.receive_line("PASS 12345")
   
   
 end
