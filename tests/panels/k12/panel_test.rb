class Tests_Panels_K12_PanelTest < Lib_Tests_WizardAcceptanceTest

  def getWizardName
    return 'k12_panel'
  end
  
  def testSite
    return "#{$target_server}/k-12/search"
  end
  
  def saveMyResults 
    return 'Sign Up to Save Your Results'
  end
  
  def runTest
    clearAll    
    update_report("[K12 Panel] Tests that user can complete Location & Distance entries",
                  testLocationAndDistance)  
    update_report("[K12 Panel] Tests that user can complete Grade Level entries",
                  testGradeLevel)           
    update_report("[K12 Panel] Tests that user can complete Characteristics entries",
                  testCharacteristics)   
    seeMore   
    update_report("[K12 Panel] Tests that user can complete Religion entries",
                  testReligion)  
    update_report("[K12 Panel] Tests that user can complete Gender entries",
                  testGender)    
    update_report("[K12 Panel] Tests that user can complete School Size entries",
                  testSchoolSize)    
    update_report("[K12 Panel] Tests that user can complete Tuition entries",
                  testTuition)  
    update_report("[K12 Panel] Tests that user can complete Diversity entries",
                  testDiversity)         
    update_report("[K12 Panel] Test that when user is filling out the k-12 panel and user goes back to k-12 homepage or dashboard then hits return to search, it lands on the k-12 panel again",
                  testBackHome)                              
  end

  private  
  
  def testLocationAndDistance
    begin
      onLocationAndDistance.text_field(:xpath => 'div[1]/div/div/div[1]/div/div[1]/input').typeBySet '0000'
      onLocationAndDistance.link(:xpath => '//*[@id="sliderChoice"]/div/a').click
      _isValid = onLocationAndDistance.div(:class => 'quickPanelErrorMessage').waitOnEval("style?('block')") 
      onLocationAndDistance.text_field(:xpath => 'div[1]/div/div/div[1]/div/div[1]/input').typeBySet 'New Albany, IN'
      sleep 2
      @watir_helper.reset.link(:text => /New Albany, IN/).click   
      onLocationAndDistance.link(:xpath => '//*[@id="sliderChoice"]/div/a').click
      _isValid = (_isValid && hasResults?)
    rescue
      _isValid = false
    end  
    
    return _isValid
  end
  
  def testGradeLevel
    begin
      onGradeLevel.checkbox(:xpath => 'div[1]/div/div/div[1]/div/div[1]/input').set  
      onGradeLevel.checkbox(:xpath => 'div[1]/div/div/div[1]/div/div[2]/input').set  
      onGradeLevel.checkbox(:xpath => 'div[1]/div/div/div[1]/div/div[3]/input').set  
      _isValid = hasResults?      
    rescue
      _isValid = false
    end
    
    return _isValid
  end

  def testCharacteristics
    begin
      onCharacteristics.checkbox(:xpath => 'div[1]/div/div/div[1]/div/div[1]/input').set  
      onCharacteristics.checkbox(:xpath => 'div[1]/div/div/div[1]/div/div[2]/input').set  
      onCharacteristics.checkbox(:xpath => 'div[1]/div/div/div[1]/div/div[3]/input').set  
      onCharacteristics.checkbox(:xpath => 'div[1]/div/div/div[1]/div/div[4]/input').set  
      onCharacteristics.checkbox(:xpath => 'div[1]/div/div/div[1]/div/div[5]/input').set  
      onCharacteristics.checkbox(:xpath => 'div[1]/div/div/div[1]/div/div[6]/input').set  
      onCharacteristics.checkbox(:xpath => 'div[1]/div/div/div[1]/div/div[7]/input').set  
      _isValid = hasResults?      
    rescue
      _isValid = false
    end
    
    return _isValid
  end

  def testReligion
    begin
      onReligion.radio(:xpath => 'div[1]/div/div/div[1]/div/div[1]/input').set  
      onReligion.select_list(:xpath => 'div[1]/div/div/div[1]/div/div[1]/div[1]/select').select 'Catholic' 
      _isValid = hasResults?      
    rescue
      _isValid = false
    end
    
    return _isValid    
  end
  
  def testGender
    begin
      onGender.radio(:xpath => 'div[1]/div/div/div[1]/div/div[1]/input').set  
      _isValid = hasResults?      
    rescue
      _isValid = false
    end
    
    return _isValid    
  end

  def testSchoolSize
    begin
      onSchoolSize.select_list(:xpath => 'div[1]/div/div/div[1]/div/div/select').select 'I have no preference'  
      _isValid = hasResults?      
    rescue
      _isValid = false
    end
    
    return _isValid  
  end
  
  def testTuition
    begin
      onTuition.link(:xpath => '//*[@id="sliderChoice"]/div/a').click
      _isValid = hasResults?      
    rescue
      _isValid = false
    end
    
    return _isValid 
  end
  
  def testDiversity
    begin
      onDiversity.select_list(:xpath => 'div[1]/div/div/div[1]/div/div/select').select 'Yes, definitely'  
      _isValid = hasResults?      
    rescue
      _isValid = false
    end
    
    return _isValid     
  end

  def seeMore
    begin
      @watir_helper.reset.find(:class => 'morePreferences').click
      sleep 2
      _hasMore = @watir_helper.reset.find(:class => 'seeLessPreferences').exists?
      #sleep 1.5
    rescue
      _hasMore = false
    end
    
    return _hasMore
  end
  
  def testBackHome
    begin
      @browser.a(:xpath, '//*[@id="pathBreadcrumb"]/div[2]/div[1]/a').click
      home = @generalTools.waitUrl("#{$target_server}/k-12",6)
      home = (home and @browser.element(:xpath, '//*[@id="location"]').attribute_value('value')=='New Albany, IN')
      home = (home and @generalTools.testSlider(/(left:\s)([0-9]+(\.[0-9]+)?%);/))
      home = (home and @browser.element(:xpath, '//*[@id="grade"]/option[2]').attribute_value('selected'))
      @browser.a(:xpath, '//*[@id="getResults"]').click
      home = (home and @generalTools.waitUrl(testSite,6))
    rescue
      home = false
    end
    return home
  end
    
  def onLocationAndDistance
    return @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[1]')
  end
  
  def onGradeLevel
    return @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[2]')
  end
  
  def onCharacteristics
    return @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[3]')
  end

  def onReligion
    return @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[4]')
  end
    
  def onGender
    return @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[5]')
  end
  
  def onSchoolSize
    return @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[6]')
  end

  def onTuition
    return @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[7]')
  end
    
  def onDiversity
    return @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[8]')
  end
end