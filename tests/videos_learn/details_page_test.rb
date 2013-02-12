class Tests_VideosLearn_DetailsPageTest < Lib_Tests_VideosAcceptanceTest
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/videos_learn/video_details_page'
  end  

  def getFriendlyName
    return "Videos Details Page"
  end
  
  def testSite
    return "#{$target_server}/learn/details/103730/why-should-you-be-an-architect"
  end
      
  def runTest  
    @watir_helper.goto testSite
    update_report("[Video Details Page] Test that user can land on the Learn page",
                  testDetailsLandingPage)
    update_report("[Video Details Page] Test that user can see that the toolbar is initially opened",
                  testToolbarClosed)      
    update_report("[Video Details Page] Test that user can see the video description is displaying",
                  testVideoDescription) 
    update_report("[Video Details Page] Test that user can see the learning opportunities section is displaying",
                  testLearningOportunities)        
    update_report("[Video Details Page] Test that user can see video recommendations are displaying",
                  testLearningOportunities)                                                                                                          
  end 
  
  def testDetailsLandingPage
    return onVideoLanding.exists?
  end
  
  def testToolbarClosed
    return !(onVideoLanding.div(:xpath => '//*[@id="pageWrap"]').attribute_value(:class).include?("toolbarOppened"))
  end
  
  def testVideoDescription
    return onDescription.div(:xpath => 'div[1]').attribute_value(:class).include?("threecol threecolWrap")
  end
  
  def testLearningOportunities
    return onDescription.div(:xpath => 'div[2]').attribute_value(:class).include?("twocol floatRight learningOpportunities")
  end
  
  def testRecommendations
    return onRecommendations.lis.size>=25
  end
  
  def onVideoLanding
    if !@VL
      @VL = @watir_helper.reset.find(:xpath => '//*[@id="squeeze"]/div').element
    end
    return @watir_helper.setElement(@VL)
  end
  
  def onDescription
    return onVideoLanding.div(:xpath => '//*[@id="videoMain"]/div[1]')
  end
  
  def onRecommendations
    return onVideoLearning.ul(:xpath => '//*[@id="relevant"]')
  end
end