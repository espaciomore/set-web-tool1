class Tests_SchoolProfiles_Pros_ProfileTest < Lib_Tools_EntityProfileFactory
  attr_accessor :testSite
  attr_accessor :entityName

  def openUrl
    @browser.goto testSite
  end

  def tabsToTest
    return ['overviewTab', 'serviceOfferedTab', 'contactInfoTab']
  end
  
  def compositeTest
    overallTest
    profileImageTest
    tabsTest 
    socialNetworkTest :askAFriend
    rightRailTest
  end
end