class Tests_StaticPages_NoodleProsCareTest < Lib_Tests_StaticPagesAcceptanceTest
  
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/static_pages/noodle_pros_care'
  end

  def testSite
    return "#{$target_server}/noodle-pros"
  end
     
  def runTest
    @browser.goto testSite
        
    testHeader testSite
    
    update_report("[Noodle-Pros][white-oak-west] Test that the Noodle-Pros page is loading with the correct content",
                  @generalTools.wait("Noodle Tutors specialize in test prep (SAT, ACT),"))
  end
end