class Tests_StaticPages_NewYorkSatTest < Lib_Tests_StaticPagesAcceptanceTest
  
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/static_pages/new_york_sat'
  end

  def testSite
    return "#{$target_server}/new-york-sat"
  end
  
  def runTest
    @browser.goto testSite
        
    testHeader testSite
    
    update_report("[Noodle-Pros][white-oak-west] Test that the Noodle-Pros page is loading with the correct content",
                  @generalTools.wait("Noodle Tutors specialize in standardized test prep"))
  end
end