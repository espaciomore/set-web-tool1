class Lib_AcceptanceTest
  
  attr_accessor :browser
  attr_accessor :report
  
  def initialize(tools=nil)
    if tools      
      @generalTools = tools
      @watir_helper = tools.watir_helper
      @browser = tools.browser
      @report = tools.report
    end
  end
  
  def test 
    if(testLoggedIn && Config_Settings::TEST_LOGGED_IN)  
      showConsoleInfo
      self::processTest( logged_in )
    end
         
    if(testLoggedOut && !$login)
      showConsoleInfo
      self::processTest( logged_out )
    end          
    
    return true
  end
  
  def showConsoleInfo
    print "\nRunning #{self.class}" 
    #********************************************************
    if $thread      
      t = Thread.current    
      print " | #{t.priority}" 
    end
    #********************************************************  
  end
  
  def processTest withLogin
    if (self::beforeSetUp)
      self::setUp
      self::afterSetUp      
      @watir_helper.goto testSite 
      if (self::caughtTest)
        self::beforeTearDown
        self::tearDown
      end
      self::afterTearDown
    end
    
    #********************************************************
    if $thread      
      t = Thread.current    
      print " | #{t.priority}" 
    end
    #********************************************************
  end  
  
  def beforeSetUp
    $isLoggedIn = false
    begin
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.timeout = 360 # =>  seconds - default is 60
      @browser = Watir::Browser.new $target_browser, :http_client => client      
      @browser.window.resize_to(1280,900) # => @browser.send_keys :f11
      @report = Lib_Tools_TestReportsFactory.new()  
      @generalTools = Lib_Tools.new(self)
      @watir_helper.clearCookies     
      _safeSetUp = true
    rescue
      _safeSetUp = false
      error = "\n\tCrashed! \nReason: " + $!.to_s
      if(Config_Settings::DEBUG)
        puts error
      end
    end
    return _safeSetUp
  end
    
  def testSite
    "#{$target_server}/"
  end
  
  def afterSetUp
  end

  def beforeTearDown
  end

  def afterTearDown
    begin
      if $target_browser==Constants::IE
        @browser.quit
      else
        @browser.close 
      end
      @report.finishReport()
    rescue
      puts :TearDownCrashed
    end
  end

  def caughtTest
    begin
      @report.createReport(self::getReportPath)
      self::runTest
      print $thread?"\nFinishing #{self.class}":" Done"      
      saveTest = true
    rescue      
      saveTest = false
      error = "\n\tCrashed! \nReason: " + $!.to_s
      if(Config_Settings::DEBUG)
        puts error
      end
      update_report(error, "CRASHED")
    end
    return saveTest
  end

  def setUp    
  end

  def getReportPath
    raise NotImplementedError
  end

  def runTest
    raise NotImplementedError
  end

  def tearDown
  end
  
  def testLoggedIn
    true
  end

  def testLoggedOut
    true
  end
  
  def update_report(description, reason)
    @generalTools.update_report(description, reason)   
  end 
  
  def report_status_passed
    @report.overallResult=='PASSED'
  end
  
  private
    
  def logged_in
    true
  end
  
  def logged_out
    false
  end
end
