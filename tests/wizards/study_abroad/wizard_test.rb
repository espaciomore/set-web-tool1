class Tests_Wizards_StudyAbroad_WizardTest < Lib_Tests_WizardAcceptanceTest

  def getWizardName
    'study_abroad_wizard'
  end
  
  def testUser
    :studyabroad
  end
  
  def testSite
    "#{$target_server}/find/study-abroad"
  end
  
  def runTest
    sleep 5
    if !(@watir_helper.reset.find(:text => 'Instructional Language').exists?)
      @wizardTools.startOver()
      
      update_report('['+getFriendlyName+'] Test that the wizards loads concurrently and quickly',
                    @watir_helper.reset.find(:xpath => '//*[@class="wizardPointer"]').exists?)  
      update_report('[Study Abroad Wizard] Validating: "Where would you be interested in studying?"',
                    test_panel1)  
      testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2508"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                        {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2509"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                        {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2510"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                         "Would you be more interested in speaking English or speaking a second language while abroad?",
                         "When are you interested in going?")  
      update_report('[Study Abroad Wizard] Question: "When are you interested in going?"',
                    test_panel2)
      update_report('[Study Abroad Wizard] Question: "You can study abroad, or do other things like intern abroad or eco/adventure abroad. Which are you interested in?"',
                    test_panel3)  
      update_report('[Study Abroad Wizard] Validating: "Please tell us a little about where you\'re studying and what year you\'re in."',
                    test_panel4)         
      update_report('[Study Abroad Wizard] Verifying that the wizard generated some results', 
                    test_results)                        
    else
      Tests_Panels_StudyAbroad_PanelTest.new(@generalTools).runTest
    end
    
    testGVI( Tests_Wizards_StudyAbroad_GridItemTest )
  end
  
  private
  
  def test_panel1
    Proc.new do
      begin
        raise "verify panel #1 present" if not @wizardTools.waitForQuestion(:text => "Where would you be interested in studying?")
        raise "verify panel #1 validation" if not @validator.validate([{'//*[@id="wizardQuestion1"]/div/div[1]/div[1]/div/input' => Lib_Forms_Fields_Location.getInstance.setLocation('Alicante, Spain')}])      
        raise "verify panel #1 submit" if not @wizardTools.waitForQuestion(:text => "Would you be more interested in speaking English or speaking a second language while abroad?")
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end
  
  def test_panel2
    Proc.new do
      begin
        raise "verify panel #2 present" if not @wizardTools.waitForQuestion(:text => "When are you interested in going")
        raise "verify panel #2 validation" if not @validator.validate([{"choiceOfQuestion2520" => Lib_Forms_Fields_CheckBox.getInstance}])      
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end  

  def test_panel3
    Proc.new do
      begin
        raise "verify panel #3 present" if not @wizardTools.waitForQuestion(:text => "Which are you interested in")
        raise "verify panel #3 validation" if not @validator.validate([{"choiceOfQuestion2521" => Lib_Forms_Fields_CheckBox.getInstance}])     
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end  

  def test_panel4
    Proc.new do
      begin
        raise "verify panel #3 present" if not @wizardTools.waitForQuestion(:text => "Please tell us a little about where you")
        raise "verify panel #3 validation" if not @validator.validate([{'choice2530' => Lib_Forms_Fields_University.getInstance.setUniversity('Yale University')},
                                               {"choice2528" => Lib_Forms_Fields_Gpa.getInstance},
                                               {'//*[@id="wizardQuestion1"]/div/div[5]/select' => Lib_Forms_Fields_ComboBox.getInstance.setOption(1)}])            
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end   
  
  def test_results    
    Proc.new do
      begin
        raise "verify last panel present" if not @generalTools.wait("Congratulations, you're done!",10)
        raise "verify final results" if not @wizardTools.verifyResults()
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end    
  end   
end