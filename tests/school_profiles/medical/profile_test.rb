class Tests_SchoolProfiles_Medical_ProfileTest < Lib_Tools_EntityProfileFactory
  attr_accessor :testSite
  attr_accessor :entityName

  def openUrl
    @browser.goto testSite
  end
  
  def tabsToTest
    return ['overview', 'academics', 'admissions','finance','outcomes']
  end
  
  def compositeTest
    overallTest
    profileImageTest
    profileFitScore
    tabsTest
    socialNetworkTest :askAFriend
    rightRailTest
    #linkedInModuleTest
  end
end