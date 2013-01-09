Given /^user not loged in$/ do
 # pending # express the regexp above with the code you wish you had
    @cucumbertest = EM::FTPD::Server.new(nil, PgFTPDriver.new)
end

When /^user tries to change directory$/ do
  #pending # express the regexp above with the code you wish you had
    @cucumbertest.reset_sent!
    @cucumbertest.receive_line("CWD")
end

Then /^user should get log in error$/ do
  #pending # express the regexp above with the code you wish you had
    @cucumbertest.sent_data.should match(/530.+/)
end

Given /^user is logged in$/ do
 # pending # express the regexp above with the code you wish you had
    
    @cucumbertest = EM::FTPD::Server.new(nil, PgFTPDriver.new)
    #create a dir to test remove
    log_in()
end

When /^user tries change directory$/ do
 # pending # express the regexp above with the code you wish you had
    @dirname = create_dir_in_db()
    @cucumbertest.receive_line("CWD #{@dirname}")
    
end

Then /^user directory should change$/ do
 # pending # express the regexp above with the code you wish you had
   @cucumbertest.sent_data.should match(/250.+/)
   remove_dir_from_db(@dirname) # Call to remove created dir
end

private

 
 def log_in_pasv() 
    @cucumbertest.receive_line("USER 12345")
    @cucumbertest.receive_line("PASS 12345")
    @cucumbertest.receive_line("PASV")
    @cucumbertest.reset_sent!
 end
 
 def create_dir_in_db() # create dir in db
    
    dirname = Dir.mktmpdir("foo")
    @newdirname = dirname.match(/([^\/.]*)$/)
    log_in()    
    @cucumbertest.receive_line("MKD #{@newdirname[0]}")    
    return @newdirname[0]
 end
 

  def remove_dir_from_db(name) # remove dir from db
   
   log_in()
    @cucumbertest.receive_line("RMD #{name}")
   
  end