class Tests_SchoolProfiles_Tutoring_ProfileTest < Lib_Tools_EntityProfileFactory
  attr_accessor :testSite
  attr_accessor :entityName

  def tabsToTest
    return ['Overview', 'officeLocations']
  end

  def openUrl
    @watir_helper.goto testSite
  end
  
  def compositeTest
    titleTest 'Wyzant Tutoring'
    overallTest
    profileImageTest
    tabsTest 
    socialNetworkTest :askAFriend
    rightRailTest
  end
end