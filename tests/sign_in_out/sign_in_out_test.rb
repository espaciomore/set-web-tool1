class Tests_SignInOut_SignInOutTest < Lib_Tests_AcceptanceTest

  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/sign_in_out/gmail_account'
  end

  def testLoggedIn
    return false
  end
  
  def testSite
    "#{$target_server}/"  
  end
  
  def runTest
    update_report("[Gmail Sign-in] Test that user can sign in on Homepage", 
                  test_homepage_login)
    update_report("[Gmail Sign-in] Test that user can sign in on Profiles", 
                  test_profiles_login) 
    update_report("[Gmail Sign-in] Test that user can sign in on Register", 
                  test_register_login) 
    update_report("[Gmail Sign-in] Test that user can sign in on Noodlings", 
                  test_noodlings_login) 
    update_report("[Gmail Sign-in] Test that user can sign in on Listings", 
                  test_listings_login)   
  end

  def test_noodlings_login
    Proc.new do
      begin
        _testSite = "#{$target_server}/noodlings"
        @watir_helper.goto _testSite
        raise "verify noodlings login" if not login({:using => :test_user, :on => :abstractHeader})  
        raise "verify noodlings redirect" if not @watir_helper.urlLike(_testSite)    
        raise "verify noodlings logout" if not logout     
        _success = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _success = false    
      end
      _success
    end     
  end

  def test_listings_login
    Proc.new do
      begin
        _testSite = "http://www.noodle.org/educate/sign-up"
        @watir_helper.goto _testSite
        sleep 2
        raise "verify listings login" if not login({:using => :test_user, :on => :abstractHeader})  
        raise "verify listings redirect" if not @watir_helper.urlLike(_testSite)    
        raise "verify listings logout" if not logout     
        _success = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _success = false    
      end
      _success
    end      
  end

  def test_homepage_login
    Proc.new do
      begin
        raise "verify homepage login" if not login({:using => :test_user, :on => :abstractHeader})  
        raise "verify homepage redirect" if not @watir_helper.urlLike("#{$target_server}/home")    
        raise "verify homepage logout" if not logout     
        _success = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _success = false    
      end
      _success
    end     
  end

  def test_profiles_login
    Proc.new do
      begin
        _testSite = "#{$target_server}/study-abroad/1472"
        @watir_helper.goto _testSite
        raise "verify profiles login" if not login({:using => :test_user, :on => :abstractHeader})  
        raise "verify profiles redirect" if not @watir_helper.urlLike(_testSite)    
        raise "verify profiles logout" if not logout     
        _success = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _success = false    
      end
      _success
    end    
  end

  def test_register_login
    Proc.new do
      begin
        _testSite = "#{$target_server}/register"
        @watir_helper.goto _testSite
        raise "verify register login" if not login({:using => :test_user, :on => :abstractHeader})  
        raise "verify register redirect" if not @watir_helper.urlLike("#{$target_server}/home")    
        raise "verify register logout" if not logout   
        @watir_helper.goto _testSite
        raise "verify register overlay login" if not login({:using => :test_user, :on => :registrationStandalone})  
        raise "verify register overlay redirect" if not @watir_helper.urlLike("#{$target_server}/home")    
        raise "verify register overlay logout" if not logout            
        _success = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _success = false    
      end
      _success
    end  
  end
end
