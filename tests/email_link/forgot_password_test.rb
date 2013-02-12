class Tests_EmailLink_ForgotPasswordTest < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/email_link/forgot_password'
  end

  def testLoggedIn
    return false
  end
  
  def testSite
    _testSite = case $target_server
      when Constants::QA then
         "#{$target_server}/forgot_password.php?data=d43hJbJ9mjuN&userName=noodle.pwd.user@gmail.com"
      when Constants::PROD then
         "#{$target_server}/forgot_password.php?data=Fw8WB5D66l33&userName=noodle.pwd.user@gmail.com"
      when Constants::DEV then  
         "#{$target_server}/forgot_password.php?data=9H7devk9s8SV&userName=noodle.pwd.user@gmail.com"
      end
    _testSite  
  end
  
  def runTest   
    update_report("[Forgot Password] Test that user can see Forgot Password page is working",
                  test_reset_password)
  end
  
  def test_reset_password
    Proc.new do
      begin
        raise "verify title is Reset Your Password" if not on_password_container.h2.text=='Reset Your Password'
        on_new_password.type '123456'
        on_confirm_password.type '6543210'
        on_save.click
        sleep 2
        raise "verify password match validation" if not @watir_helper.reset.div( :text => /Passwords must match/).visible?
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end
  
  def on_password_container
    @watir_helper.reset.div( :xpath => '//*[@id="passwordFieldsContainer"]' )
  end
  
  def on_new_password
    on_password_container.text_field( :xpath => 'div[1]/input' )
  end
  
  def on_confirm_password
    on_password_container.text_field( :xpath => 'div[2]/input' )
  end
  
  def on_save
    on_password_container.link( :xpath => 'div[3]/a' )
  end
end
