class Tests_MonitoringService_GeneralMonitoring < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/monitoring_service/general_monitoring'
  end
  
  def testLoggedIn
    return false
  end

  def testSite
    return "#{$target_server}/services/general_monitoring.php?token=DK2KKGuvUQSsylvZiNLLMLnrng6hQYAWj4gvBUhXk"
  end  
  
  def runTest  
    @values = JSON.parse("{}")
    
    update_report("[General Monitoring] Test that users are able to recieve emails from Noodle",
                  test_service_results)    
    update_report("[General Monitoring] Results: #{JSON.pretty_unparse(@values)}", true)
  end
  
  def test_service_results
    Proc.new do
      begin
        _response = @watir_helper.reset.find(:xpath => '/html/body').text
        @values = JSON.parse(_response)      
        raise "verify emails hash has key emails" if not @values.has_key?("emails")
        raise "verify emails hash has key emailsJobStatus" if not @values["emails"].has_key?("emailsJobStatus")
        raise "verify queue is empty" if not @values["emails"]["emailsJobStatus"]=="EmailsAreBeingSent"
        _isValid = true  
      rescue Exception => e
        puts "FAILED to #{e}"
      end
      _isValid
    end
  end
end