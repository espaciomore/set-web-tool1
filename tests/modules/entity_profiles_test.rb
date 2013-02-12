class Tests_Modules_EntityProfilesTest < Lib_Tests_AcceptanceTest
  
  def getReportPath
    return "#{Config_Paths::REPORT_FOLDER_PATH}/modules/entity_profiles"
  end  

  def testLoggedIn
    return false
  end
    
  def runTest
    testEntityProfile
  end
  
  private
  def testEntityProfile
    entities = [
                #{:name=>'College',:href=>'/college/new-york-university',:object=>Tests_SchoolProfiles_College_ProfileTest},                
                {:name=>'K-12',:href=>'/k-12/sc/la-france/la-france-elementary',:object=>Tests_SchoolProfiles_K12_ProfileTest},
                {:name=>'Law',:href=>'/graduate/harvard-law-school/juris-doctor',:object=>Tests_SchoolProfiles_Law_ProfileTest},
                {:name=>'Medical',:href=>'/medical/vanderbilt-university-school-of-medicine',:object=>Tests_SchoolProfiles_Medical_ProfileTest},
                {:name=>'Program',:href=>'/graduate/ohio-state-university/biochemistry-program',:object=>Tests_SchoolProfiles_Program_ProfileTest},
                {:name=>'Pros',:href=>'/pros',:object=>Tests_SchoolProfiles_Pros_ProfileTest},
                {:name=>'Study Abroad',:href=>'/study-abroad/1472',:object=>Tests_SchoolProfiles_StudyAbroad_ProfileTest},
                {:name=>'University',:href=>'/graduate/university-of-georgia',:object=>Tests_SchoolProfiles_University_ProfileTest},
                {:name=>'Tutoring',:href=>'/tutoring-test-prep/wyzant-tutoring',:object=>Tests_SchoolProfiles_Tutoring_ProfileTest},
                ]
    entities.each do |entity|
      _this = entity[:object].new(@generalTools)
      _this.testSite = "#{$target_server}#{entity[:href]}"
      _this.entityName = entity[:name]
      _this.openUrl 
      _this.compositeTest
    end
  end      
end