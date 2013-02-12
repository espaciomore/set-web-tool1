class Tests_SignInOut_FacebookConnectTest < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/sign_in_out/facebook_connect'
  end

  def testLoggedIn
    return false
  end
  
  def runTest
    update_report("[Facebook Connect]Test that user can use Facebook Connect on Homepage", 
                  test_homepage_login)
    update_report("[Facebook Connect]Test that user can use Facebook Connect on Profiles", 
                  test_profiles_login)
    update_report("[Facebook Connect]Test that user can use Facebook Connect on Noodlings", 
                  test_noodlings_login)  
    update_report("[Facebook Connect]Test that user can use Facebook Connect on Register", 
                  test_register_login)           
  end

  def test_register_login
    Proc.new do
      begin
        _testSite = "#{$target_server}/register"
        @watir_helper.goto _testSite
        raise "verify register login" if not login({:using => :facebook, :on => :contentWrapper})  
        raise "verify register redirect" if not @watir_helper.urlLike("#{$target_server}/home")  
        raise "verify register logout" if not logout
        _testSite = "#{$target_server}/register"
        @watir_helper.goto _testSite
        raise "verify register center login" if not login({:using => :facebook, :on => :registrationStandalone})  
        raise "verify register center redirect" if not @watir_helper.urlLike("#{$target_server}/home")     
        raise "verify register center logout" if not logout    
        _success = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _success = false    
      end
      _success
    end
  end

  def test_noodlings_login
    Proc.new do
      begin
        _testSite = "#{$target_server}/noodlings"
        @watir_helper.goto _testSite
        raise "verify noodlings login" if not login({:using => :facebook, :on => :abstractHeader})  
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

  def test_profiles_login
    Proc.new do
      begin
        _testSite = "#{$target_server}/study-abroad/1472"
        @watir_helper.goto _testSite
        raise "verify profiles login" if not login({:using => :facebook, :on => :abstractHeader})  
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

  def test_homepage_login
    Proc.new do
      begin
        @watir_helper.goto $target_server
        raise "verify homepage login" if not login({:using => :facebook, :on => :abstractHeader})  
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
end