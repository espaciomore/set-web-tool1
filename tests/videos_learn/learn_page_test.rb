class Tests_VideosLearn_LearnPageTest < Lib_Tests_VideosAcceptanceTest
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/videos_learn/videos_page'
  end  
  
  def getFriendlyName
    return "Learn Page"
  end
  
  def testSite
    return "#{$target_server}/learn"
  end
      
  def runTest  
    @watir_helper.goto testSite
    update_report("[Videos Page] Test that user can land on the Learn page",
                  testLandingPage)
    update_report("[Videos Page] Test that user can see that the toolbar is initially opened",
                  testToolbarOpened)        
    update_report("[Videos Page] Test that user can see the four sections (Monthly features, Noodle Picks, What's New, What's Popular) concerning top videos",
                  testTopVideos)    
    update_report("[Videos Page] Test that user can see that the video details page",
                  testVideoDetailsPage)                                         
  end 
  
  def testLandingPage
    return onVideoLanding.exists?
  end
  
  def testToolbarOpened
    return onVideoLanding.div(:xpath => '//*[@id="pageWrap"]').attribute_value(:class).include?("toolbarOppened")
  end
  
  def testTopVideos
    begin
      _hasSections = onVideoTop.divs.size==4
    rescue
      _hasSections = false
    end
    
    return _hasSections
  end
  
  def testVideoDetailsPage
    begin
      _url = onMonthlyFeatures.link(:xpath => 'li[1]/span[1]/span[1]/span[2]/a[1]').attribute_value(:href)
      @watir_helper.goto "#{_url}"
      _isVisible = @watir_helper.urlLike "#{$target_server}/learn/details"
    rescue
      _isVisible = false
    end
    
    return _isVisible
  end
  
  def onVideoLanding
    if !@VL
      @VL = @watir_helper.reset.find(:xpath => '//*[@id="squeeze"]/div').element
    end
    return @watir_helper.setElement(@VL)
  end
  
  def onVideoTop
    return onVideoLanding.find(:xpath => '//*[@id="videoTop"]')
  end
  
  def onMonthlyFeatures
    return onVideoTop.ul(:xpath => '//*[@id="videoHeader"]/div[2]/div/div[1]/div/ul')
  end
end