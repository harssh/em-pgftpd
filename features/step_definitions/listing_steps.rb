When /^user tries to listing$/ do
  #pending # express the regexp above with the code you wish you had
     
     @cucumbertest.reset_sent!
     @cucumbertest.receive_line("LIST")

end

When /^user tries listing on root$/ do
  #pending # express the regexp above with the code you wish you had
    @cucumbertest.receive_line("PASV")
    @cucumbertest.reset_sent!
    @cucumbertest.receive_line("LIST")
end

Then /^user should get listing on root$/ do
    @cucumbertest.sent_data.should match(/150.+226.+/m)
end

When /^user tries listing inside directory$/ do
    @dirname = create_dir_in_db()
    @cucumbertest.receive_line("CWD #{@dirname}")
    @cucumbertest.receive_line("CWD #{@dirname}")
    @cucumbertest.receive_line("PASV")
    @cucumbertest.reset_sent!
    @cucumbertest.receive_line("LIST")
end

Then /^user should get listing on selected directory$/ do
    @cucumbertest.sent_data.should match(/150.+226.+/m)
    remove_dir_from_db(@dirname) # Call to remove created dir 
end




private

def log_in()
   
   @cucumbertest.receive_line("USER 12345")
   @cucumbertest.receive_line("PASS 12345")
   @cucumbertest.reset_sent!
   
 end
 
 def log_in_pasv() 
    @cucumbertest.receive_line("USER 12345")
    @cucumbertest.receive_line("PASS 12345")
    @cucumbertest.receive_line("PASV")
    @cucumbertest.reset_sent!
 end