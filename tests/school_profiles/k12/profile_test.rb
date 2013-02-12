class Tests_SchoolProfiles_K12_ProfileTest < Lib_Tools_EntityProfileFactory
  attr_accessor :testSite
  attr_accessor :entityName

  def openUrl
    @browser.goto testSite
  end
  
  def tabsToTest
    return ['overview', 'academicsAndStudents', 'district']
  end
  
  def compositeTest
    overallTest
    profileImageTest
    profileFitScore
    tabsTest
    socialNetworkTest :askAFriend
    rightRailTest
  end
end