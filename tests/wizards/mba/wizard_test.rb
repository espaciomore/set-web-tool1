class Tests_Wizards_Mba_WizardTest < Lib_Tests_WizardAcceptanceTest

  def getWizardName
    'mba_wizard'
  end
  
  def testUser
    :mba
  end

  def testSite
    "#{$target_server}/find/mba"
  end
  
  def runTest
    @wizardTools.startOver()

    update_report('[MBA Wizard][currytown] Test that the wizards loads concurrently and quickly',
                  @watir_helper.reset.find(:xpath => '//*[@class="wizardPointer"]').exists?)   
    update_report('[MBA Wizard] Validating: "Please tell us about your undergraduate studies, so we can show you programs right for you."',
                  test_panel1)
    update_report('[MBA Wizard] Validating: "What is your best GMAT score?" (a)',
                  test_panel2a)
    update_report('[MBA Wizard] Validating: "What is your best GMAT score?" (b)',
                  test_panel2b)
    update_report('[MBA Wizard] Validating: "What are your best SAT or ACT scores?"',
                  test_panel3)
    update_report('[MBA Wizard] Validating: "How many months of work experience do you have?"',
                  test_panel4)
    
    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2463"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2464"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2465"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                     "How would you describe the company where you held your best job?",
                     "How would you describe the quality of your best job, on a 1-5 scale?") 

    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2466"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2467"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2468"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2469"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2470"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                     "How would you describe the quality of your best job, on a 1-5 scale?",
                     "Why are you interested in an MBA?") 

    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2471"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2472"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2473"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                     "Why are you interested in an MBA?",
                     "How would you describe your work history?") 

    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2476"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2477"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2478"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                     "How would you describe your work history?",
                     "Congratulations, you're done!")
    
    update_report('[MBA Wizard] Verifying that the wizard generated some results', 
                  test_results)
                  
    testGVI( Tests_Wizards_Mba_GridItemTest )
  end
  
  private 
  
  def test_panel1
    Proc.new do
      begin
        raise "verify panel #1 present" if not @wizardTools.waitForQuestion(:text => /Please tell us about your undergraduate studies/)
        raise "verify panel #1 validation" if not @validator.validate([{"choice2452" => Lib_Forms_Fields_University.getInstance.setUniversity('Berkeley College-New York')},
                                             {"choice2454" => Lib_Forms_Fields_Gpa.getInstance},
                                             {'//*[@id="wizardQuestion1"]/div/div[5]/select' => Lib_Forms_Fields_ComboBox.getInstance.setOption(1)}
                                             ])
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end

  def test_panel2a
    Proc.new do
      begin
        raise "verify panel #2 (a) present" if not @wizardTools.waitForQuestion(:text => "What is your best GMAT score?")
        raise "verify panel #2 (a) validation" if not @validator.validate([{"choice2456" => Lib_Forms_Fields_Gmat.getInstance}])
        raise "verify panel #2 (a) submit" if not @wizardTools.waitForQuestion(:text => "How many months of work experience do you have?")
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end 

  def test_panel2b
    Proc.new do
      begin
        @wizardTools.prevQuestion()
        sleep 1
        raise "verify panel #2 (b) present" if not @wizardTools.waitForQuestion(:text => "What is your best GMAT score?")
        @watir_helper.reset.checkbox(:name => "choiceOfQuestion851").click
        @wizardTools.submit()
        sleep 1
        raise "verify panel #2 (b) submit" if not @wizardTools.waitForQuestion(:text => "What are your best SAT or ACT scores?")
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
        @validator.clearValuesFor({"choice2458" => Lib_Forms_Fields_Sat.getInstance})
        @validator.clearValuesFor({"choice2459" => Lib_Forms_Fields_Sat.getInstance})
        @validator.clearValuesFor({"choice2460" => Lib_Forms_Fields_Sat.getInstance})
        @validator.clearValuesFor({"choice2461" => Lib_Forms_Fields_Sat.getInstance})
        raise "verify panel #3 validation" if not @validator.validate([{"choice2458" => Lib_Forms_Fields_Sat.getInstance},{"choice2459" => Lib_Forms_Fields_Sat.getInstance}])
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
        raise "verify panel #4 present" if not @wizardTools.waitForQuestion(:text => "How many months of work experience do you have?")
        raise "verify panel #4 validation" if not @validator.validate([{"choice2462" => Lib_Forms_Fields_MonthsOfExperience.getInstance}])
        raise "verify panel #4 submit" if not @wizardTools.waitForQuestion(:text => "How would you describe the company where you held your best job?")
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