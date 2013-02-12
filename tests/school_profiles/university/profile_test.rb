class Tests_SchoolProfiles_University_ProfileTest < Lib_Tools_EntityProfileFactory
  attr_accessor :testSite
  attr_accessor :entityName

  def openUrl
    @browser.goto testSite
  end

  def tabsToTest
    return ['about']
  end
  
  def compositeTest
    overallTest
    profileImageTest
    tabsTest
    socialNetworkTest :askAFriend
    rightRailTest
    linkedInModuleTest 'The University of Georgia'
  end
end