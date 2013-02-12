class Tests_Provider_ProfilesTest < Lib_Tests_AcceptanceTest
  
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/provider/provider_profiles'
  end
  
  def testLoggedIn
    return false
  end
  
  def runTest
    @profile = Tests_Provider_ProfilePage.new(@generalTools)
    (Config_Mappings::PROVIDER_URL).each do |key,value|
      @watir_helper.goto "#{$target_server}/learn/provider/#{value}"
      _success = @watir_helper.urlLike "#{$target_server}/learn/provider/#{value}"
      update_report("[#{key}] Test that user can see that the profile image is loaded",
                          _success ? @profile.testProfileImage : 'CRASHED')
      update_report("[#{key}] Test that user can see that the profile header title is matching provider name",
                          _success ? @profile.testHeaderTitle(key) : 'CRASHED')  
      update_report("[#{key}] Test that user can see that the profile breadcrum has the right composition",
                          _success ? @profile.testBreadcrumb( {:titles => ['Learning Materials', key]} ) : 'CRASHED')                                                  
    end
  end  
end