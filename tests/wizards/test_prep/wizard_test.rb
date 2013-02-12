class Tests_Wizards_TestPrep_WizardTest < Lib_Tests_WizardAcceptanceTest
  def getWizardName
    return 'test_prep_wizard'
  end
  
  def testUser
    return :testprep
  end
  
  def verifyFitScoreOnProfile
    #nothing
  end
  
  def testSite
    return "#{$target_server}/find/test-prep"
  end
  
  def runTest
    @browser.goto testSite
    
    @wizardTools.startOver()

    update_report('[Test Prep Wizard][currytown] Test that the wizards loads concurrently and quickly',
                  @watir_helper.reset.find(:xpath => '//*[@class="wizardPointer"]').exists?)
                            
    update_report('[Test Prep Wizard] Question: "Which subject or test would you like tutoring in?" and Question: "Where would you like to meet with your tutor?"',
                  testPanel1)  
    
    update_report('[Test Prep Wizard] Question: "When do you plan to take the test?" and Question: "When would you like to start tutoring?"',
                  (@generalTools.wait("When do you plan to take the test?", 10) and
                        @validator.validate([{'//*[@id="wizardQuestion1"]/div/div/select' => Lib_Forms_Fields_ComboBox.getInstance.setOption(1)},
                                             {'choice2159' => Lib_Forms_Fields_DateNow.getInstance}])))

    update_report('[Test Prep Wizard] Question: "Would you prefer private or group tutoring?"',
                  (@generalTools.wait("How would you like to study?", 10) and
                        @validator.validate([{'choiceOfQuestion2146' => Lib_Forms_Fields_CheckBox.getInstance}])))  

    @generalTools.wait("Do you want in-home tutoring?", 10)
    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2424"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2425"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true},],
                     "Do you want in-home tutoring?",
                     "What is your budget?") 
    
    update_report('[Test Prep Wizard] Question: "What is your budget?"',
                  @validator.validate([{'//*[@id="sliderChoice"]/div[1]/a[1]' => Lib_Forms_Fields_Link.getInstance}]))
    
    update_report('[Test Prep Wizard] Verifying that the wizard generated some results', 
                  hasResults?)    
    @generalTools.wait("Congratulations, you're done!", 5)                                                

    testGVI( Tests_Wizards_TestPrep_GridItemTest )
  end

  private
  
  def testPanel1
    if @generalTools.wait("Which subject or test would you like tutoring in?")
      begin
        @watir_helper.reset.text_field(:name => 'choice2100').typeBySet 'Invalid'
        @watir_helper.reset.text_field(:name => 'choice2101').typeBySet '00000'
        @watir_helper.reset.span(:text => 'Apply').click
        canValidate = @generalTools.wait('Please insert valid values')
      rescue
        canValidate = false
      end      
      begin
        @watir_helper.reset.text_field(:name => 'choice2100').typeBySet 'SAT Math I'
        @watir_helper.reset.link(:text => 'SAT Math I').click
        @watir_helper.reset.text_field(:name => 'choice2101').typeBySet '07901'
        @watir_helper.reset.span(:text => 'Apply').click
        question1 = @generalTools.wait('When do you plan to take the test?')
      rescue
        question1 = false
      end      
      return (canValidate && question1)
    end
    return false
  end
end