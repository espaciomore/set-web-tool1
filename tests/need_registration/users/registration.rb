class Tests_NeedRegistration_Users_Registration < Lib_Tests_AcceptanceTest
  
  def testLoggedIn
    return false
  end
  
  def getReportPath
    return Config_Paths::USERS_REPORT_FOLDER_PATH + '/registration'
  end

  def testSite
    "#{$target_server}/"
  end
  
  def runTest 
    update_report("[Registration] Test that user can see the Sign Up Overlay on Noodle Homepage",
                  test_get_overlay_on_homepage )
    update_report("[Registration] Test that user see validation in the Sign Up Overlay on Noodle Homepage",
                  test_validate_entries_for_new_user )  
    update_report("[Registration] Test that users has to agree with temrs of service before user can sign up with facebook",
                  test_validate_facebook_agreement ) 
    update_report("[Registration] Test that users under the age of 13 years can't sign up",
                  test_validate_birthdate_for_new_user )    
    update_report("[Registration] Test that user can see the Sign Up Overlay again",
                  test_get_overlay_on_homepage )                    
    update_report("[Registration] Test that users over the age of 12 years can sign up",
                  test_register_new_user )     
    removeUser()      
  end

  def test_get_overlay_on_homepage
    Proc.new { get_overlay_on_homepage } 
  end
  
  def test_validate_entries_for_new_user
    Proc.new { validate_entries_for_new_user } 
  end 

  def test_validate_facebook_agreement
    Proc.new { validate_facebook_agreement }
  end
  
  def test_validate_birthdate_for_new_user
    Proc.new { validate_birthdate_for_new_user }
  end
  
  def test_register_new_user
    Proc.new { register_new_user }
  end    
end