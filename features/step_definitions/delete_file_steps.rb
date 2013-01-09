When /^unauthenticated user tries to delete file$/ do
   @cucumbertest.reset_sent!
    @cucumbertest.receive_line("DELE x")
end

When /^user tries to delete file$/ do
  
    @filename = put_files_in_db() # create file on remote
    @cucumbertest.reset_sent!
    remove_file_from_db(@filename)
    
end

Then /^user should get success message$/ do
  @cucumbertest.sent_data.should match(/250.+/)
end