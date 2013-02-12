class Tests_SchoolProfiles_Program_ProfileTest < Lib_Tools_EntityProfileFactory
  attr_accessor :testSite
  attr_accessor :entityName

  def openUrl
    @browser.goto testSite
  end

  def tabsToTest
    return ['at-a-glance', 'faculty', 'academics', 'admissions']
  end
  
  def compositeTest
    overallTest
    profileImageTest
    profileFitScore
    tabsTest
    socialNetworkTest :askAFriend
    rightRailTest
    linkedInModuleTest 'The Ohio State University'
  end
  
end