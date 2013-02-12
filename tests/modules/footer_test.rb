class Tests_Modules_FooterTest < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/modules/footer_module'
  end

  def testLoggedIn
    return false
  end
  
  def testSite
    return "#{$target_server}"
  end
  
  def runTest
    @browser.goto testSite
    update_report('[Footer Module] Verifying user can see copyright for the correct date year', 
                        @generalTools.waitOrCrash("Noodle Copyright " + Time.now.year.to_s + " All Rights Reserved"))
  end
end