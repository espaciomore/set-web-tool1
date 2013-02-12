class Tests_NeedRegistration_AbleSentry_WizardThenSignup < Tests_NeedRegistration_AbleSentry_WizardTest
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/able_sentry_project/wizard_then_signup'
  end

  def testLoggedIn
    return false
  end

  def testSite
    return "#{$target_server}/home"
  end
  
  def register_user
    'noodle.test.asentry@gmail.com'  
  end
  
  def runTest
    testWizard()
    sleep 2
    update_report("[Able Sentry Project]] Test that users over the age of 12 years can sign up",
                  test_register_new_user )   
    removeUser()    
  end
  
  private 
  
  def test_register_new_user
    Proc.new do
      begin
        raise "verify age over 12 years can sign up" if not register_new_user
        isValid = true
      rescue Exception => e 
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end  
end