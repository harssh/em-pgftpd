When /^unauthorised user tries to make directory$/ do
  @cucumbertest.reset_sent!
  @cucumbertest.receive_line("MKD x")
end

When /^user tries make directory$/ do
    @tempdirname = [*('A'..'Z')].sample(8).join
    @cucumbertest.receive_line("MKD #{@tempdirname}")
    remove_dir_from_db(@tempdirname) #call to remove created dir
end