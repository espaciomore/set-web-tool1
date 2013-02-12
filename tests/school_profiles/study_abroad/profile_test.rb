class Tests_SchoolProfiles_StudyAbroad_ProfileTest < Lib_Tools_EntityProfileFactory
  attr_accessor :testSite
  attr_accessor :entityName

  def openUrl
    @browser.goto testSite
  end

  def tabsToTest
    return ['Overview', 'Eligibility_And_Cost', 'Housing_And_Location', 'Provider_Info']
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