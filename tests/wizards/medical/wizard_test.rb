class Tests_Wizards_Medical_WizardTest < Lib_Tests_WizardAcceptanceTest

  def getWizardName
    return 'medical_wizard'
  end
  
  def testUser
    return :medical
  end

  def testSite
    return "#{$target_server}/medical/search"
  end
  
  def runTest
    testGradWizardRedirect
    
    @wizardTools.startOver()
     
    update_report('[Medical Wizard][currytown] Test that the wizards loads concurrently and quickly',
                  @generalTools.wait('//*[@class="wizardPointer"]',5,true))    
     
    update_report('[Medical Wizard][581] Test that the /medical search page title is "Medical School | Find a Medical School| Noodle Education"',
                  (@browser.title == 'Medical School | Find a Medical School | Noodle Education'))
    
    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion25673"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion25674"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion25675"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion25676"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                     "What do you see yourself doing after medical school?",
                     "Where do you want to spend most of your time?")      
                                         
    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion25677"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion25678"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion25679"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                     "Where do you want to spend most of your time?",
                     "Where would you like to study?")
                                                                 
    update_report('[Medical Wizard] Validating: "Where would you like to study?"',
                  @validator.validate([{'//*[@id="wizardQuestion1"]/div/div[1]/input' => Lib_Forms_Fields_Location.getInstance.setLocation('33166')}]))

    update_report('[Medical Wizard] Validating: "Where did/will you complete your undergraduate degree?"',
                  (@generalTools.wait('Where did/will you complete your undergraduate degree?') and
                        @validator.validate([{'choice25682' => Lib_Forms_Fields_University.getInstance.setUniversity('Berkeley College-New York')},
                                             {"choice25683" => Lib_Forms_Fields_Gpa.getInstance}])))

    update_report('[Medical Wizard] Validating: "What year do you expect to begin medical school?"',
                  (@generalTools.wait('What year do you expect to begin medical school?') and
                        @validator.validate([{'//*[@id="wizardQuestion1"]/div/div/select' => Lib_Forms_Fields_ComboBox.getInstance.setOption(1)}])))

    update_report('[Medical Wizard] Validating: "What are your best MCAT scores?"',
                  (@generalTools.wait("What are your best MCAT scores?") and
                        @validator.validate([{"choice25685" => Lib_Forms_Fields_Mcat_VerbalReasoning.getInstance},
                                             {"choice25686" => Lib_Forms_Fields_Mcat_PhysicalSciences.getInstance},
                                             {"choice25687" => Lib_Forms_Fields_Mcat_BiologicalSciences.getInstance},
                                             {"choice25688" => Lib_Forms_Fields_Mcat_WritingSamples.getInstance}])))
                                                                                                                                                                                              
    update_report('[Medical Wizard] Verifying that the wizard generated some results', 
                  hasResults?)
    
    @generalTools.wait("Congratulations, you're done!")
    
    testGVI( Tests_Wizards_Medical_GridItemTest )
  end

  def testGradWizardRedirect
    gradWizardSite = "#{$target_server}/find/graduate"
    ['M.D.', 'D.O.'].each do |program|
      @watir_helper.goto gradWizardSite    
      @wizardTools.startOver()    
      begin
        @generalTools.wait("Social and Behavioral Sciences",5)   
        @watir_helper.reset.select_list(:xpath => '//*[@id="wizardQuestion1"]/div/div/select').select 'Medicine'
        @generalTools.wait(program)
        @watir_helper.reset.select_list(:xpath => '//*[@id="wizardQuestion2"]/div/div/select').select program
        @wizardTools.submit()
        result = @generalTools.waitUrl("#{$target_server}/medical/search",6)
      rescue
        result = false
      end
      update_report("[Medical Wizard][582] Test that selecting Medicine Field and #{program} Program  on Graduate wizard redirects to Medical Wizard",
                    result)
    end
  end
end