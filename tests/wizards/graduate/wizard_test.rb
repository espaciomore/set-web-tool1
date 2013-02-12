class Tests_Wizards_Graduate_WizardTest < Lib_Tests_WizardAcceptanceTest

  def getWizardName
    return 'graduate_wizard'
  end
  
  def testUser
    return :graduate 
  end
  
  def testSite
    return "#{$target_server}/find/graduate"  
  end
  
  def runTest
    @wizardTools.startOver()
    
    update_report('['+getFriendlyName+'] Test that the wizards loads concurrently and quickly',
                  @watir_helper.reset.find(:xpath => '//*[@class="wizardPointer"]').exists?)      
    update_report("[Graduate Wizard] Test that user can get passed the first panel",
                  test_panel1)
    # => second panel              
    testOptions([{"choice"=>"choiceOfQuestion2420","hasResults"=>false},
                 {"choice"=>"choiceOfQuestion2421","hasResults"=>false}],
                  "Which types of degree are you looking for?",
                  Lib_Forms_Fields_CheckBox.getInstance)    
    update_report('[Graduate Wizard] Test that user can get passed the third panel',
                  test_panel3)                  
    update_report('[Graduate Wizard] Test that user can get passed the fourth panel (a)',
                  test_panel4a)
    update_report('[Graduate Wizard] Test that user can get passed the fourth panel (b)',
                  test_panel4b)  
    update_report('[Graduate Wizard] Test that user can get passed the fifth panel',
                  test_panel5)     
    update_report('[Graduate Wizard] Test that user can get passed the sixth panel (a)',
                  test_panel6a)
    update_report('[Graduate Wizard] Test that user can get passed the sixth panel (a)',
                  test_panel6b)                        
    update_report('[Graduate Wizard] Test that user can see that the wizard generated some results', 
                  test_results)
    
    testGVI( Tests_Wizards_Graduate_GridItemTest )
  end
  
  def test_panel1
    Proc.new do
      begin
        raise "verify wizard loaded" if not @watir_helper.reset.find(:xpath => '//*[@class="wizardPointer"]').exists?
        raise "verify first panel present" if not @wizardTools.waitForQuestion(:text => "Which field of study are you interested in?")
        raise "verify first panel select input loaded" if not wait('<select class="graduateFieldOfStudy">')
        raise "verify first panel select entries" if not @validator.validate([{'//*[@id="wizardQuestion1"]/div/div/select' => Lib_Forms_Fields_GraduateStudy.getInstance},
              {'//*[@id="wizardQuestion2"]/div/div/select' => Lib_Forms_Fields_GraduateStudy.getInstance}])
        @wizardTools.submit() 
        raise "verify first panel submit" if not @wizardTools.verifyResults()
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
        raise "verify third panel present" if not @wizardTools.waitForQuestion(:text => "Please tell us about your undergraduate studies, so we can show you programs right for you.")
        raise "verify third panel entries" if not @validator.validate([{"choice2430" => Lib_Forms_Fields_University.getInstance.setUniversity('Yale University')},
              {"choice2432" => Lib_Forms_Fields_Gpa.getInstance}, {'//*[@id="wizardQuestion1"]/div/div[5]/select' => Lib_Forms_Fields_ComboBox.getInstance.setOption(1)},])
        isValid = true  
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end
  
  def test_panel4a
    Proc.new do
      begin
        raise "verify fourth panel (a) present" if not @wizardTools.waitForQuestion(:text => "What are your best GRE scores?")
        raise "verify fourth panel (a) entries" if not @validator.validate([{"choice2434" => Lib_Forms_Fields_GreVerbal.getInstance},
              {"choice2435" => Lib_Forms_Fields_GreQuantitative.getInstance},{"choice2436" => Lib_Forms_Fields_GreAnalytical.getInstance}])
        raise "verify fourth panel submit" if not wait('Congratulations')
        isValid = true  
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end  

  def test_panel4b
    Proc.new do
      begin
        @wizardTools.prevQuestion()
        sleep 3
        raise "verify fourth panel (b) present" if not @wizardTools.waitForQuestion( :text => "What are your best GRE scores?" )
        raise "verify fourth panel (b) checkbox entry" if not @validator.validate({'choiceOfQuestion2437' => Lib_Forms_Fields_CheckBox.getInstance})
        isValid = true  
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end   
  
  def test_panel5
    Proc.new do
      begin
        raise "verify fifth panel present" if not @wizardTools.waitForQuestion(:text => "What are your best SAT or ACT scores?")
        raise "verify fifth panel present entry SAT critical reading" if not @validator.clearValuesFor({"choice2438" => Lib_Forms_Fields_Sat.getInstance})
        raise "verify fifth panel present entry SAT quantivie reasoning" if not @validator.clearValuesFor({"choice2439" => Lib_Forms_Fields_Sat.getInstance})
        raise "verify fifth panel present entry SAT writing" if not @validator.clearValuesFor({'choice2440' => Lib_Forms_Fields_Sat.getInstance})
        raise "verify fifth panel present entry ACT composite" if not @validator.clearValuesFor({'choice2441' => Lib_Forms_Fields_ActComposite.getInstance})
        isValid = true  
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end
  
  def test_panel6a
    Proc.new do
      begin
        raise "verify sixth panel (a) present" if not @wizardTools.waitForQuestion(:text => 'What are your best SAT or ACT scores?')
        raise "verify sixth panel (a) SAT reading and reasoning entries" if not @validator.validate([{"choice2438" => Lib_Forms_Fields_Sat.getInstance},{"choice2439" => Lib_Forms_Fields_Sat.getInstance}])
        raise "verify sixth panel (a) submit" if not wait('Congratulations')
        isValid = true  
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end
  
  def test_panel6b
    Proc.new do
      begin
        @wizardTools.prevQuestion()
        sleep 3
        raise "verify sixth panel (b) present" if not @wizardTools.waitForQuestion(:text => "What are your best SAT or ACT scores?")
        @validator.clearValuesFor({"choice2438" => Lib_Forms_Fields_Sat.getInstance})
        @validator.clearValuesFor({"choice2439" => Lib_Forms_Fields_Sat.getInstance})
        raise "verify sixth panel (b) ACT composite entries" if not @validator.validate({'choice2441' => Lib_Forms_Fields_ActComposite.getInstance})
        raise "verify sixth panel (b) submit" if not wait('Congratulations')
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
        raise "verify results" if not hasResults?
        isValid = true  
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end  
end