require 'spec_helper'

describe EM::FTPD::Server, "initial" do

  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end

  it "should default to a root name_prefix" do
    @test.name_prefix.should eql("/")
  end

  it "should respond with 220 when connection is opened" do
    @test.sent_data.should match(/^220/)
  end
end


describe EM::FTPD::Server, "Authorisation" do
  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end
  context "with authorised access" do
       it "should respond with 230 " do
        @test.receive_line("USER 12345")
        @test.reset_sent!
        @test.receive_line("PASS 12345")
        @test.sent_data.should match(/230.+/)
       end
  end
  
  context "with unauthorised access as no password" do
    it "should respond with 553 " do
      @test.receive_line("USER 12345")
      @test.reset_sent!
      @test.receive_line("PASS")
      @test.sent_data.should match(/553.+/)
    end
  end
  
  context "with unauthorised access as no params" do
    it "should respond with 553 " do
      @test.receive_line("USER")
      @test.reset_sent!
      @test.receive_line("PASS")
      @test.sent_data.should match(/553.+/)
    end
  end
   
end


describe EM::FTPD::Server, "Make dir" do
  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end

  context "Unauthorised user calls make_dir" do
   it "should respond with 530 " do
    @test.reset_sent!
    @test.receive_line("MKD x")
    @test.sent_data.should match(/530.*/)
   end
  end
  
  context "Logged in user calls Make dir" do
   it "should respond with 257 when the directory is created" do
    @test.receive_line("USER 12345")
    @test.receive_line("PASS 12345")
    @test.reset_sent!
    @test.receive_line("MKD four")
    @test.sent_data.should match(/257.+/)
   end
  end
 
end


describe EM::FTPD::Server, "Remove Dir" do
  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end

 context "Logged in user calls delete dir" do
   it "should respond with 250 " do
    @test.receive_line("USER 12345")
    @test.receive_line("PASS 12345")
    @test.reset_sent!
    @test.receive_line("RMD four")
    @test.sent_data.should match(/250.+/)
  end
 end

  context "Logged in user calls delete dir with wrong dir" do
    it "should respond with 550 " do
     @test.receive_line("USER 12345")
     @test.receive_line("PASS 12345")
     @test.reset_sent!
     @test.receive_line("RMD x")
     @test.sent_data.should match("")
   end
  end

end


describe EM::FTPD::Server, "Change_dir" do
  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end

  context "not logged in" do
   it "should respond with 530" do
    @test.reset_sent!
    @test.receive_line("CWD")
    @test.sent_data.should match(/530.*/)
   end
  end
  
  context "Logged in and calls CD" do
   it "should respond with 250 if called with 'data' " do
    @test.receive_line("USER 12345")
    @test.receive_line("PASS 12345")
    @test.reset_sent!
    @test.receive_line("CWD data")
    @test.sent_data.should match(/250.+/)
    @test.name_prefix.should eql("/data")
   end
  end
end


describe EM::FTPD::Server, "Dir LIST" do
  
  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end
   
  context "Unauthorised user calls DIR" do
    it "should respond with 530 " do
     @test.reset_sent!
     @test.receive_line("LIST")
     @test.sent_data.should match(/530.+/)
    end
  end

  context "Logged in user calls dir" do
      
   it "should respond with 150 ...425  when called with no data socket" do
     @test.receive_line("USER 12345")
     @test.receive_line("PASS 12345")
     @test.reset_sent!
     @test.receive_line("LIST")
     @test.sent_data.should match(/150.+425.+/m)
   end

  it "should respond with 150 ... 226 when called in the root dir with no param" do
   
    @test.receive_line("USER 12345")
    @test.receive_line("PASS 12345")
    @test.receive_line("PASV")
    @test.reset_sent!
    @test.receive_line("LIST")
    @test.sent_data.should match(/150.+226.+/m)
   
  end

   it "should respond with 150 ... 226 when called in the files dir with no param" do
    @test.receive_line("USER 12345")
    @test.receive_line("PASS 12345")
    @test.receive_line("CWD data")
    @test.receive_line("PASV")
    @test.reset_sent!
    @test.receive_line("LIST")
    @test.sent_data.should match(/150.+226.+/m)
    
   end
  end
end


describe EM::FTPD::Server, "Put Files" do
  
  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end


  context "Unauthorised user calls Put files" do
    it "should respond with 530 " do
      @test.reset_sent!
      @test.receive_line("stor")
      @test.sent_data.should match(/530.+/)
    end
  end
 
  context "Logged in user calls PUT File" do
      
   it "should respond with 150 ...553 when called with no data socket" do
     @test.receive_line("USER 12345")
     @test.receive_line("PASS 12345")
     @test.reset_sent!
     @test.receive_line("STOR")
     @test.sent_data.should match(/553.+/)
   end

 
   it "should respond with 150 ... 226 when called in the put files " do
     @test.receive_line("USER 12345")
     @test.receive_line("PASS 12345")
     @test.receive_line("PASV")
     @test.reset_sent!
     @test.receive_line("STOR /home/harssh/Documents/filesquery filesquery")
    @test.sent_data.should match(/150.+200.+/m)
   end
  end 

end

describe EM::FTPD::Server, "Delete Files" do
  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end

 context "Called by Not Logged in user" do
  it "should respond with 530 " do
    @test.reset_sent!
    @test.receive_line("DELE x")
    @test.sent_data.should match(/530.*/)
  end
end

context "Logged in user calls delete file" do
  it "should respond with 553 when the no paramater " do
    @test.receive_line("USER 12345")
    @test.receive_line("PASS 12345")
    @test.reset_sent!
    @test.reset_sent!
    @test.receive_line("DELE")
    @test.sent_data.should match(/553.+/)
  end

  it "should respond with 250 when the file is deleted" do
    @test.receive_line("USER 12345")
    @test.receive_line("PASS 12345")
    @test.reset_sent!
    @test.reset_sent!
    @test.receive_line("DELE filesquery filesquery")
    @test.sent_data.should match(/250.+/)
  end

  it "should respond with 550 when the file is not deleted" do
    @test.receive_line("USER 12345")
    @test.receive_line("PASS 12345")
    @test.reset_sent!
    @test.reset_sent!
    @test.receive_line("DELE filesquery2")
    @test.sent_data.should match(/250.+/)
  end

 end
end

describe EM::FTPD::Server, "Get Files" do
  before(:each) do
    @test = EM::FTPD::Server.new(nil, PgFTPDriver.new)
  end
 context "Called by not logged in user" do
 it "should always respond with 530 " do
    @test.reset_sent!
    @test.receive_line("RETR filesquery")
    @test.sent_data.should match(/530.+/)
  end
 end

 context "Logged in user calls get files" do
  
   it "should respond with 553 when called with no param" do
     @test.receive_line("USER 12345")
     @test.receive_line("PASS 12345")
     @test.reset_sent!
     @test.receive_line("RETR")
     @test.sent_data.should match(/553.+/)
   end

  
   it "should always respond with 551 when called with an invalid file" do
     @test.receive_line("USER 12345")
     @test.receive_line("PASS 12345")
     @test.receive_line("PASV")
     @test.reset_sent!
     @test.receive_line("RETR filesquery2")
     @test.sent_data.should_not match(/551.+/)
   end

   it "should always respond with 150..226 when called with valid file" do
     @test.receive_line("USER 12345")
     @test.receive_line("PASS 12345")
     @test.receive_line("PASV")
     @test.reset_sent!
     @test.receive_line("RETR filesquery")
     @test.sent_data.should_not match("/226.+/")
   end
 end
end