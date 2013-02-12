class Tests_SchoolProfiles_Law_ProfileTest < Lib_Tools_EntityProfileFactory
  attr_accessor :testSite
  attr_accessor :entityName

  def openUrl
    @browser.goto testSite
  end
  
  def tabsToTest
    return ['at-a-glance', 'faculty', 'academics', 'admissions','tuition-and-expenses','career-outcomes']
  end
  
  def compositeTest
    overallTest
    profileImageTest
    profileFitScore
    tabsTest
    socialNetworkTest :askAFriend
    rightRailTest
    linkedInModuleTest 'Harvard University'
  end
end