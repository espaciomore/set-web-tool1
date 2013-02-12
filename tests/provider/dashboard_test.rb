class Tests_Provider_DashboardTest < Lib_Tests_AcceptanceTest
  
  def testLoggedOut
    return false
  end

  def isProvider
    return true
  end
  
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/provider/provider_services'
  end

  def testSite
    return "#{$target_server}/home"
  end
  
  def runTest
    @watir_helper.goto testSite
    update_report('[Provider Dashboard] Test that user can see that the Provider Service lists are appearing', 
                  testProviderServicesList)
  end

  def testProviderServicesList
    begin
      _hasLinks = @watir_helper.reset.find(:xpath => '//*[@id="providerServices"]/ul').exists? #Does ul tag appear ?
      _hasLinks = (_hasLinks && @watir_helper.reset.find(:xpath => '//*[@id="providerServices"]/ul/li[1]/a').exists?) #First link must appear
      _hasLinks = (_hasLinks && @watir_helper.reset.find(:xpath => '//*[@id="providerServices"]/ul/li[2]/a').exists?) #Second least one link must appear
    rescue
      _hasLinks = false
    end
    
    return _hasLinks
  end
end