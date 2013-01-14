When /^user tries to download$/ do
   
   begin
     @ftp.get("x")
   rescue Exception => @e
     puts @e
   
   end  

end

When /^user tries to download without params$/ do
   begin
     @ftp.get()
   rescue Exception => @e
     puts @e
   end  
end

Then /^user should get error params not present$/ do
   
   
    @e.message.should match(/wrong number of arguments/)
    
end

When /^user tries to download with params$/ do
    
    begin
     @filename = create_tempfile()
     
     @ftp.put(@file.path,@filename)
     
     @ftp.get(@filename)
     
    rescue Exception => @e
     puts @e
     
   ensure 
       
     @file.unlink  
     
   end
end

Then /^user should get download success$/ do
      
     @ftp.last_response_code.should match(/226/)    
     
     @ftp.delete(@filename)
     remove_file_from_sys(@filename)
end

When /^user tries to download invalid file$/ do
    begin
     @ftp.get("x")
   rescue Exception => @e
     puts @e
   end  

end

Then /^user should get invalid file error$/ do
     @e.message.should match(/551 file not available/)
end



private

 def remove_file_from_sys(filename) #removes file from system
  if File.exist?("#{filename}")
     
     FileUtils.rm("#{filename}")
  
   end
  end
