class Tests_Wizards_College_WizardTest < Lib_Tests_WizardAcceptanceTest
  def getWizardName
    'college_wizard'
  end
  
  def testUser
    :college 
  end
  
  def testSite
    "#{$target_server}/find/college"
  end
  
  def runTest 
    @wizardTools.startOver()
    
    update_report('['+getFriendlyName+'] Test that the wizards loads concurrently and quickly',
                  @watir_helper.reset.find(:xpath => '//*[@class="wizardPointer"]').exists?)             
    update_report('[College Wizard] Validating: "What did you score on the SAT/ACT?"',
                  test_panel1)                      
    update_report('[College Wizard] Validating: "Tell us a little bit about your high school..."',
                  test_panel2)    
    
    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2531"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2532"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2533"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                       "It's a Saturday evening on campus. What are you most likely doing?",
                       "What's your ideal work load?")
    
    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2534"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2535"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2536"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                       "What's your ideal work load?",
                       "What size college do you think you'd like?")

    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2549"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2550"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2551"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2552"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                       "What size college do you think you'd like?",
                       "Is there a particular region, state, or city where you'd like to be?")
                                                             
    update_report("[College Wizard] Question: Is there a particular region, state, or city where you'd like to be? ",
                  test_panel6)
                        
    goBackTwoStep = report_status_passed && @generalTools.wait("To tailgate or not to tailgate: do you want a school where sports are big on campus?", 10)
    
    #the next question are skipped if user type in the state
    if not goBackTwoStep
      testOptions([{"choice"=>"choiceOfQuestion25664","hasResults"=>true},
                                 {"choice"=>"choiceOfQuestion25665","hasResults"=>true},
                                 {"choice"=>"choiceOfQuestion25666","hasResults"=>true},
                                 {"choice"=>"choiceOfQuestion25667","hasResults"=>true},
                                 {"choice"=>"choiceOfQuestion25663","hasResults"=>true}],
                                 "Which type of setting most appeals to you?",
                                 Lib_Forms_Fields_CheckBox.getInstance)
  
      testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion25668"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                        {:selector => :xpath, :value => '//*[@id="choiceOfQuestion25669"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                        {:selector => :xpath, :value => '//*[@id="choiceOfQuestion25670"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                        {:selector => :xpath, :value => '//*[@id="choiceOfQuestion25671"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                         "How would the weather at a school affect your decision?",
                         "To tailgate or not to tailgate: do you want a school where sports are big on campus?")
      @wizardTools.prevQuestion() 
      sleep 1
      @wizardTools.prevQuestion()                          
    end
                               
    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2553"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2554"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2555"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                       "To tailgate or not to tailgate: do you want a school where sports are big on campus?",
                       "I am...")

    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2556"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2557"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2558"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                       "I am...",
                       "In my application, I'll mark my ethnicity as:")
                               
    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2559"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2560"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2561"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2562"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2563"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2564"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2565"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                       "In my application, I'll mark my ethnicity as:",
                       "How do you feel about fraternities and sororities?")

    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2566"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2567"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2568"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2569"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2570"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                       "How do you feel about fraternities and sororities?",
                       "Some schools have a religious affiliation. How do you feel about that?")

    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2571"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2572"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false}],
                       "Some schools have a religious affiliation. How do you feel about that?",
                       "How much does cost matter?")    

    update_report("[College Wizard] Dropdown: \"Which religion is that?\"",
                  test_panel12)

    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2577"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false}],
                       "How much does cost matter?",
                       "In order to estimate your weighted GPA, please tell us how many AP or honors courses you took, if any.")
                       
    update_report("[College Wizard] Dropdown: \"Where do you qualify for in-state tuition? (It's probably the state you live in.)\"",
                  test_panel14)

    update_report("[College Wizard] Question: \"In order to estimate your weighted GPA, please tell us how many AP or honors courses you took, if any.\"",
                  test_panel15)
                            
    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2581"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2582"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2583"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2584"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                       "Did you participate in clubs, community service, or student government?",
                       "Were you involved in music, fine arts or the performing arts?")
    
    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2586"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2585"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2587"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2588"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                       "Were you involved in music, fine arts or the performing arts?",
                       "Did you play sports during high school? If so, which sport were you most involved with?")
    if report_status_passed
      @generalTools.wait("Did you play sports during high school? If so, which sport were you most involved with?",5)
      @watir_helper.reset.select_list(:xpath => '//*[@id="wizardQuestion1"]/div/div[1]/select').select "Basketball"
    end
    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2590"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2591"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2592"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2593"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                       "Did you play sports during high school? If so, which sport were you most involved with?",
                       "Did you have a job during high school?")
                               
    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2594"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2595"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2596"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                       "Did you have a job during high school?",
                       "Is it important to you to that your classmates come from a diverse range of nationalities, ethnicities, beliefs and backgrounds?")

    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2597"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2598"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2599"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2600"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                       "Is it important to you to that your classmates come from a diverse range of nationalities, ethnicities, beliefs and backgrounds?",
                       "What is the highest level of education completed by either of your parents?")

    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2601"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2602"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false}],
                       "What is the highest level of education completed by either of your parents?",
                       "Congratulations, you're done!")
    
    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2603"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2604"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                       "What is the highest level of education completed by either of your parents?",
                       "Where did your parents go to college?")
    
    update_report('[College Wizard] Question: "Where did your parents go to college?"',
                  test_panel23)                                      
    update_report('[College Wizard] Verifying that the wizard generated some results', 
                  test_results)    
    
    testGVI(Tests_Wizards_College_GridItemTest)
  end

  private

  def test_panel1
    Proc.new do
      begin
        raise "verify panel #1 present" if not @wizardTools.waitForQuestion(:text => 'What did you score on the SAT/ACT?')
        raise "verify panel #1 validates" if not @validator.validate([{"choice2537" => Lib_Forms_Fields_Sat.getInstance},
                                             {"choice2538" => Lib_Forms_Fields_Sat.getInstance},
                                             {"choice2539" => Lib_Forms_Fields_Sat.getInstance},])
        raise "verify panel #1 submit" if not @wizardTools.waitForQuestion(:text => 'Tell us a little bit about your high school...')
        @wizardTools.prevQuestion()
        raise "verify return to panel #1" if not @wizardTools.waitForQuestion(:text => 'What did you score on the SAT/ACT?') 
        @watir_helper.reset.text_field(:name => "choice2537").set ''
        @watir_helper.reset.text_field(:name => "choice2538").set ''
        @watir_helper.reset.text_field(:name => "choice2539").set ''    
        raise "verify panel #1 (b) validates" if not @validator.validate([{"choice2540" => Lib_Forms_Fields_ActComposite.getInstance}])                                             
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
        raise "verify panel #2 present" if not @wizardTools.waitForQuestion(:text => "Tell us a little bit about your high school...")
        @watir_helper.reset.text_field(:name => 'choice2545').type 'invalid'
        @watir_helper.reset.text_field(:name => 'choice2547').type '00000'
        @wizardTools.submit()
        raise "verify panel #2 validates" if not @generalTools.wait("Please insert valid values",10)
        @watir_helper.reset.text_field(:name => 'choice2545').typeBySet 'Springfield Secondary - Springfield, MN'
        @watir_helper.reset.link(:text => 'Springfield Secondary - Springfield, MN').click 
        @watir_helper.reset.text_field(:name => 'choice2547').typeBySet '3.5'
        @watir_helper.reset.select_list(:xpath => '//*[@id="wizardQuestion1"]/div/div[5]/select').select '2017'
        @wizardTools.submit()
        sleep 1
        raise "verify panel #2 submit" if not @wizardTools.waitForQuestion(:text => "It's a Saturday evening on campus. What are you most likely doing?")
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end

  def test_panel6
    Proc.new do
      begin
        raise "verify panel #6 present" if not @generalTools.wait("Is there a particular region, state, or city where you'd like to be?", 10)
        raise "verify panel #6 validates" if not @validator.validate({'choice25662' => Lib_Forms_Fields_State.getInstance.setState('33166')})
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end 

  def test_panel12
    Proc.new do
      begin
        raise "verify 'Religious affiliation' present" if not @generalTools.wait("Some schools have a religious affiliation. How do you feel about that?", 10)
        @watir_helper.reset.find(:xpath => '//*[@id="choiceOfQuestion2573"]/a/table/tbody/tr/td[1]/div').clickOn
        @watir_helper.reset.select_list(:xpath => '//*[@id="wizardQuestion2"]/div/div/select').select 'Roman Catholic'
        raise "verify panel #13 present" if not @generalTools.wait('How much does cost matter?', 10)
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end 

  def test_panel14
    Proc.new do
      begin
        raise "verify 'Cost matters' present" if not @generalTools.wait("How much does cost matter?", 5)
        @watir_helper.reset.find(:xpath => '//*[@id="choiceOfQuestion2575"]/a/table/tbody/tr/td[1]/div').clickOn
        @watir_helper.reset.select_list(:xpath => '//*[@id="wizardQuestion2"]/div/div/select').select 'Alabama'
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end 
  
  def test_panel15
    Proc.new do
      begin
        raise "verify panel #15 present" if not @generalTools.wait("In order to estimate your weighted GPA, please tell us how many AP or honors courses you took, if any.", 10) 
        raise "verify panel #15 validates" if not @validator.validate([{'choiceOfQuestion2607' => Lib_Forms_Fields_CheckBox.getInstance}])
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end    

  def test_panel23
    Proc.new do
      begin
        raise "verify panel #23 present" if not @generalTools.wait("Where did your parents go to college?",10)
        raise "verify panel #23 validates" if not @validator.validate([{'choice2605' => Lib_Forms_Fields_University.getInstance.setUniversity('Nova Southeastern University')}])
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