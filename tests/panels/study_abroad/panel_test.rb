class Tests_Panels_StudyAbroad_PanelTest < Lib_Tests_WizardAcceptanceTest

  def getWizardName
    return 'study_abroad_panel'
  end
  
  def testSite
    return "#{$target_server}/find/study-abroad"
  end
  
  def saveMyResults 
    return 'Sign Up to Save Your Results'
  end  
  
  def runTest    
    clearAll
    
    update_report("[Study Abroad Panel] Tests that user can complete Location entries",
                  test_location)
    update_report("[Study Abroad Panel] Tests that user can complete Instructional Language entries",
                  test_instructional_language)  
    update_report("[Study Abroad Panel] Tests that user can complete Terms entries",
                  test_terms)
    update_report("[Study Abroad Panel] Tests that user can complete Accepting Applications entries",
                  test_accepting_applications) 
    update_report("[Study Abroad Panel] Tests that user can complete Academics entries",
                  test_academics)  
    update_report("[Study Abroad Panel] Tests that user can complete Program Characteristics entries",
                  test_program_characteristics)                                                                                                                             
  end
  
  private
  
  def test_location
    Proc.new do
      begin
        onLocation.select_list(:xpath => 'div[1]/select').select 'Europe'
        sleep 2
        onLocation.select_list(:xpath => 'div[2]/select').select 'England'
        sleep 2
        onLocation.select_list(:xpath => 'div[3]/select').select 'London'   
        raise "verify location generates results" if not hasResults?
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end
  
  def test_instructional_language
    Proc.new do
      begin
        onInstructionalLanguage.select_list(:xpath => 'div[1]/select').select 'Spanish'  
        raise "verify instructional language generates results" if not hasResults?
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end

  def test_terms
    Proc.new do
      begin
        onTerms.select_list(:xpath => 'div[1]/select').select 'Fall 2013'  
        raise "verify terms generates results" if not hasResults?
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end
  
  def test_accepting_applications
    Proc.new do
      begin
        onAcceptingApplications.checkbox(:xpath => 'div[1]/input').set   
        raise "verify accepting applications generates results" if not hasResults?
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end
  
  def test_academics
    Proc.new do
      begin
        onAcademics.text_field(:xpath => 'div[1]/input').typeBySet 'none'
        onAcademics.text_field(:xpath => 'div[3]/input').typeBySet '5.0'  
        onAcademics.select_list(:xpath => 'div[4]/select').select '2017'   
        raise "verify academics validation" if not @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[5]/div[1]/div/div/div[2]/div').waitOnEval("style?('block')")  
        onAcademics.text_field(:xpath => 'div[1]/input').typeBySet 'Berkeley College-New York'
        @watir_helper.reset.link(:text => /Berkeley College-New York/).click
        onAcademics.text_field(:xpath => 'div[3]/input').typeBySet '3.0'    
        raise "verify academics generates results" if not hasResults?
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end
  
  def test_program_characteristics
    Proc.new do
      begin
        onProgramCharacteristics.checkbox(:xpath => 'div[1]/input').set  
        onProgramCharacteristics.checkbox(:xpath => 'div[2]/input').set  
        onProgramCharacteristics.checkbox(:xpath => 'div[3]/input').set     
        raise "verify program characteristics generates results" if not hasResults?
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid   
    end
  end
          
  def onLocation
    @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[1]/div[1]/div/div/div[1]/div')
  end
  
  def onInstructionalLanguage
    @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[2]/div[1]/div/div/div[1]/div')
  end
  
  def onTerms
    @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[3]/div[1]/div/div/div[1]/div')
  end  
  
  def onAcceptingApplications    
    @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[4]/div[1]/div/div/div[1]/div')
  end
  
  def onAcademics
    @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[5]/div[1]/div/div/div[1]/div')
  end
  
  def onProgramCharacteristics
    @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[6]/div[1]/div/div/div[1]/div')
  end 
end