When /^user tries to download$/ do
    @cucumbertest.reset_sent!
    @cucumbertest.receive_line("RETR x")
end

When /^user tries to download without params$/ do
     @cucumbertest.reset_sent!
     @cucumbertest.receive_line("RETR")
end

Then /^user should get error params not present$/ do
     @cucumbertest.sent_data.should match(/553.+/)
end

When /^user tries to download with params$/ do
     @filename = put_files_in_db()
     log_in_pasv()
     @cucumbertest.receive_line("RETR #{@filename} /tmp/#{@filename}")
     @cucumbertest.sent_data.should match(//)
     remove_file_from_db(@filename) # from database
     remove_file_from_sys(@filename) # delete file from tmp directory
end

Then /^user should get download success$/ do
     @cucumbertest.sent_data.should match(//)
     remove_file_from_db(@filename) # from database
     remove_file_from_sys(@filename) # delete file from tmp directory
end

When /^user tries to download invalid file$/ do
     @cucumbertest.receive_line("RETR x")
end

Then /^user should get invalid file error$/ do
     @cucumbertest.sent_data.should_not match(/551.+/)
end


private


 def create_tempfile() # create a tempfile
   
   @file = Tempfile.new('random')
      
   @file.write("hello world") 
   
   name = @file.path
   
   @newfilenam = name.match(/([^\/.]*)$/)
     
   @newfilename = @newfilenam[0]
     
   return @newfilename
     
 end
 
 def remove_file_from_db(filename) # removes file from db
    log_in()
    @cucumbertest.reset_sent!
    @cucumbertest.receive_line("DELE #{filename}")
    @file.close
    
    @file.unlink
    
 end
 
 def put_files_in_db() # puts file in db
    @filename = create_tempfile()
    log_in_pasv()
    @cucumbertest.receive_line("STOR #{@filename} /tmp/#{@filename}")
    return @filename
 end

 def remove_file_from_sys(filename) #removes file from system
  if File.exist?("/tmp/#{filename}")
     
     FileUtils.rm("/tmp/#{filename}")
  
   end
  end
