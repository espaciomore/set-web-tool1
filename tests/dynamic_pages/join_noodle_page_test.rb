class Tests_DynamicPages_JoinNoodlePageTest < Lib_Tests_AcceptanceTest

  def getReportPath
    Config_Paths::REPORT_FOLDER_PATH + '/dynamic_pages/join_noodle_title'
  end
  
  def testLoggedOut
    false
  end

  def testSite
    "#{$target_server}/join-noodle-2"
  end
  
  def runTest
    update_report("[Join Noodle Page] Test that user can see Page Title is Join Noodle, not Join Noodle 2", 
                  test_title)
  end

  def test_title
    Proc.new do
      begin
        raise "verify title is Join Noodle" if !(@browser.title == "Join Noodle | Noodle Education")
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid 
    end
  end
end