class Tests_China_LandingPageTest < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/china/china_landing_page'
  end
  
  def testLoggedIn
    return false
  end

  def testSite
    return "#{$target_server}/cn/home"
  end  
  
  def runTest
    update_report("[China] Test that user can't see a chinese landing page because of IP blocking",
                  test_landing_page)
    update_report("[China] Test that the user is redirected to Noodle Homepage",
                  test_redirect)                                              
  end
  
  private
  
  def test_landing_page
    Proc.new do
      begin
        @watir_helper.urlLike "#{$target_server}"
        raise "verify IP blocking" if @watir_helper.reset.p(:text => /5,000/).exists?
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end 
  
  def test_redirect
    Proc.new do
      begin
        raise "verify IP redirect" if not @browser.url=="#{$target_server}/"
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end   
end