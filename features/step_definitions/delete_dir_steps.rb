When /^unauthorised user tries to delete directory$/ do
  @cucumbertest.reset_sent!
  @cucumbertest.receive_line("RMD x")
end

When /^user tries delete directory$/ do
    name = create_dir_in_db() #create a dir to test remove
    @cucumbertest.reset_sent!
     
    @cucumbertest.receive_line("RMD #{name}")
   
end

Then /^user directory should be deleted$/ do
   @cucumbertest.sent_data.should match(/250.+/)
end