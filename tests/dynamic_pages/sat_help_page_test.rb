class Tests_DynamicPages_SatHelpPageTest < Lib_Tests_AcceptanceTest
  def getReportPath
    Config_Paths::REPORT_FOLDER_PATH + '/dynamic_pages/sat_help_page'
  end

  def testLoggedIn
    false
  end

  def testSite
    "#{$target_server}"
  end

  def runTest
    update_report("[SAT Help Page] Test that user can see page is loading", 
                  test_page)
  end

  def test_page
    Proc.new do
      begin
        _testSite = "#{$target_server}/small-group/122/I-need-SAT-help"
        @browser.goto _testSite
        raise "verify page is loading" if not @generalTools.wait('I need SAT help', 5)    
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid 
    end
  end
end