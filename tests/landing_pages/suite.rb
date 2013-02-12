class Tests_LandingPages_Suite
  def test
    tests = [
             Tests_LandingPages_Schools_K12HomepageTest,
             Tests_LandingPages_Preschool_PsLandingPageTest,
             Tests_LandingPages_AfterSchool_AsLandingPageTest,
             Tests_LandingPages_StudentTravel_StLandingPageTest,
             Tests_LandingPages_LearningDisabilities_LdLandingPageTest,
             Tests_LandingPages_ReligiousEducation_ReLandingPageTest,
             Tests_LandingPages_ArtDesign_AdLandingPageTest,
             Tests_LandingPages_Music_MuLandingPageTest,
            ]
            
    Lib_TaskScheduler.new(false).addTasks(tests).runTasks()
    
    tests = [        
             Tests_LandingPages_Dance_DaLandingPageTest,
             Tests_LandingPages_Fitness_FiLandingPageTest,
             Tests_LandingPages_LanguageInstruction_LaLandingPageTest,
             Tests_LandingPages_SportsCoaching_ScLandingPageTest,
             Tests_LandingPages_ContinuingEducation_CeLandingPageTest,
             Tests_LandingPages_Internships_InLandingPageTest,
             Tests_LandingPages_Technology_TeLandingPageTest,
             Tests_LandingPages_ProfessionalDevelopment_PdLandingPageTest,
             Tests_LandingPages_CareerCounseling_CaLandingPageTest,
             Tests_LandingPages_VocationalSchools_VoLandingPageTest,
            ]
            
    Lib_TaskScheduler.new(false).addTasks(tests).runTasks()
  end
end