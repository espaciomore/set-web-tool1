class Libs_AcceptanceTest
  
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
    if(test_logged_in && Config_Settings::TEST_LOGGED_IN)  
      show_console_info
      self::process_test( logged_in )
    end
         
    if(test_logged_out && !$login)
      show_console_info
      self::process_test( logged_out )
    end          
    
    return true
  end
  
  def show_console_info
    print "\nRunning #{self.class}" 
    #********************************************************
    if $thread      
      t = Thread.current    
      print " | #{t.priority}" 
    end
    #********************************************************  
  end
  
  def process_test withLogin
    if (self::before_set_up)
      self::set_up
      self::after_set_up      
      @watir_helper.goto test_target_site 
      if (self::test_safe_exec)
        self::before_tear_down
        self::tear_down
      end
      self::after_tear_down
    end
    
    #********************************************************
    if $thread      
      t = Thread.current    
      print " | #{t.priority}" 
    end
    #********************************************************
  end  
  
  def before_set_up
    $isLoggedIn = false
    begin
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.timeout = 360 # =>  seconds - default is 60
      @browser = Watir::Browser.new $target_browser, :http_client => client      
      @browser.window.resize_to(1280,900) # => @browser.send_keys :f11
      @report = Libs_Tools_TestReportsFactory.new()  
      @generalTools = Libs_Tools.new(self)
      @watir_helper = Libs_Tools_WatirHelper.new(self) 
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
    
  def test_target_site
    "#{$target_server}/"
  end
  
  def after_set_up
  end

  def before_tear_down
  end

  def tear_down
  end
  
  def after_tear_down
    begin
      if $target_browser==Config_Constants::IE
        @browser.quit
      else
        @browser.close 
      end
      @report.finishReport()
    rescue
      puts :TearDownCrashed
    end
  end

  def test_safe_exec
    begin
      @report.createReport(self::test_report_path)
      self::test_exec
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

  def set_up    
  end

  def test_report_path
    raise NotImplementedError
  end

  def test_exec
    raise NotImplementedError
  end
  
  def test_logged_in
    true
  end

  def test_logged_out
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
