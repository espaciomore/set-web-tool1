class Tests_Wizards_Tutoring_WizardTest < Lib_Tests_WizardAcceptanceTest

  def getWizardName
    return 'academic_tutoring_wizard'
  end
  
  def testUser
    return :tutoring
  end
  
  def testSite
    return "#{$target_server}/find/tutoring"  
  end
  
  def runTest
    sleep 5
    if (@watir_helper.reset.find( :text => 'Location & Distance').exists? || @watir_helper.reset.find( :text => 'Budget').exists?)      
    
      Tests_Panels_AcademicTutoring_PanelTest.new(@generalTools).runTest         
    
    else  
      
      @wizardTools.startOver()
      update_report('[Academic Tutoring Wizard][currytown] Test that the wizards loads concurrently and quickly',
                    @watir_helper.reset.find(:xpath => '//*[@class="wizardPointer"]').exists?)
                              
      update_report('[Academic Tutoring Wizard] Validating: "Which subject or test would you like tutoring in?" and "Location"',
                    (@wizardTools.waitForQuestion(:text => "Which subject or test would you like tutoring in?") and
                          testPanel1))
  
      update_report('[Academic Tutoring Wizard] Question: "When would you like to start tutoring?"',
                          ((@wizardTools.waitForQuestion(:text => "When would you like to start tutoring?") and
                          @validator.validate([{'choice2189' => Lib_Forms_Fields_DateNow.getInstance},]))))
  
      @wizardTools.waitForQuestion(:text => "Would you prefer private or group tutoring?")
      testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2007"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                        {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2008"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                        {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2009"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true},],
                       "Would you prefer private or group tutoring?",
                       "Do you want in-home tutoring?") 
  
      @wizardTools.waitForQuestion(:text => "Do you want in-home tutoring?")
      testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2426"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                        {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2427"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true},],
                       "Do you want in-home tutoring?",
                       "What is your budget?") 
  
      update_report('[Academic Tutoring Wizard] Question: "What is your budget?"',
                    (@wizardTools.waitForQuestion(:text => "What is your budget?") and
                          @validator.validate([{'//*[@id="sliderChoice"]/div[1]/a[1]' => Lib_Forms_Fields_Link.getInstance}])))
  
      update_report('[Academic Tutoring Wizard] Question: "Please provide us with a few details"',
                    (@wizardTools.waitForQuestion(:text => "Please provide us with a few details") and
                          @validator.validate([{'choice2016' => Lib_Forms_Fields_University.getInstance.setUniversity('Berkeley College-New York')},
                                               {"choice2017" => Lib_Forms_Fields_Gpa.getInstance},
                                               {'//*[@id="wizardQuestion1"]/div/div[4]/select' => Lib_Forms_Fields_ComboBox.getInstance.setOption(1)}])))
  
      update_report('[Academic Tutoring Wizard] Verifying that the wizard generated some results', @wizardTools.verifyResults)
      
      @generalTools.wait("Congratulations, you're done!")
    end
    
    testGVI( Tests_Wizards_Tutoring_GridItemTest )
  end

  private
  
  def testPanel1
    if @generalTools.wait("Which subject or test would you like tutoring in?")
      begin
        @watir_helper.reset.text_field(:name => 'choice2000').typeBySet 'Invalid'
        @watir_helper.reset.text_field(:name => 'choice2001').typeBySet '00000'
        @watir_helper.reset.find(:text => 'Apply').click
        canValidate = @generalTools.wait('Please insert valid values')
      rescue
        canValidate = false
      end      
      begin
        @watir_helper.reset.text_field(:name => 'choice2000').typeBySet 'AP Calculus AB'
        @watir_helper.reset.link(:text => 'AP Calculus AB').click
        @watir_helper.reset.text_field(:name => 'choice2001').typeBySet '07901'
        @watir_helper.reset.find(:text => 'Apply').click
        question1 = @wizardTools.verifyResults()
      rescue
        question1 = false
      end      
      return (canValidate && question1)
    end
    return false
  end
end
