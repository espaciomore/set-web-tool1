class Tests_SchoolProfiles_College_ProfileTest < Lib_Tools_EntityProfileFactory
  attr_accessor :testSite
  attr_accessor :entityName

  def tabsToTest
    return ['overview', 'academics', 'studentLife', 'finance', 'admissions', 'applying', 'rankings']
  end
  
  def openUrl
    @watir_helper.goto testSite
  end
  
  def compositeTest
    overallTest
    profileImageTest
    profileFitScore
    tabsTest
    socialNetworkTest :askAFriend
    rightRailTest(['rigthModulesGraduateOutcomes', 
                   'Most Recent Noodlings'])
    linkedInModuleTest 'New York University'
  end
end