class Tests_Wizards_Law_WizardTest < Lib_Tests_WizardAcceptanceTest

  def getWizardName
    'law_wizard'
  end
  
  def testUser
    :law
  end
  
  def testSite
    "#{$target_server}/find/law"
  end
  
  def runTest     
    @wizardTools.startOver()
    
    update_report('['+getFriendlyName+'] Test that the wizards loads concurrently and quickly',
                  @watir_helper.reset.find(:xpath => '//*[@class="wizardPointer"]').exists?)                 
    update_report('[Law Wizard] Validating: "Please tell us about your undergraduate studies, so we can show you programs right for you."',
                  test_panel1)
    update_report('[Law Wizard] Validating: "What is your best LSAT score?" (a)',
                  test_panel2a)
    update_report('[Law Wizard] Validating: "What is your best LSAT score?" (b)',
                  test_panel2b)     
    update_report('[Law Wizard] Validating: "What are your best SAT or ACT scores?" (a) First two values should pass by themselves',
                  test_panel3a)
    update_report('[Law Wizard] Validating: "What are your best SAT or ACT scores?" (b) ACT Composite question logic. It should pass even if input by itself',
                  test_panel3b)
    
    testGVI( Tests_Wizards_Law_GridItemTest )
  end

  private
  
  def test_panel1
    Proc.new do
      begin
        raise "verify panel #1 present" if not @wizardTools.waitForQuestion(:text => /Please tell us about your undergraduate studies/)
        raise "verify panel #1 validation" if not @validator.validate([{'//*[@id="wizardQuestion1"]/div/div[5]/select' => Lib_Forms_Fields_ComboBox.getInstance.setOption(1)},
                                               {"choice2442" => Lib_Forms_Fields_University.getInstance.setUniversity('Yale University')},
                                               {"choice2444" => Lib_Forms_Fields_Gpa.getInstance},
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
        raise "verify panel #2 (a) present" if not @wizardTools.waitForQuestion(:text => "What is your best LSAT score?") 
        raise "verify panel #2 (a) validation" if not @validator.validate([{"choice2446" => Lib_Forms_Fields_Lsat.getInstance}])
        raise "verify panel #2 (a) submit" if not @generalTools.wait("Congratulations, you're done!")
        raise "verify panel #2 (a) results" if not @wizardTools.verifyResults
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
        raise "verify panel #2 (b) present" if not @wizardTools.waitForQuestion(:text => "What is your best LSAT score?")
        raise "verify panel #2 (b) validation" if not @validator.validate({"choiceOfQuestion2447" => Lib_Forms_Fields_CheckBox.getInstance})
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end 
  
  def test_panel3a
    Proc.new do
      begin
        raise "verify panel #3 (a) present" if not @wizardTools.waitForQuestion(:text => "What are your best SAT or ACT scores?")
        @validator.clearValuesFor({"choice2448" => Lib_Forms_Fields_Sat.getInstance})
        @validator.clearValuesFor({"choice2449" => Lib_Forms_Fields_Sat.getInstance})
        @validator.clearValuesFor({'choice2450' => Lib_Forms_Fields_Sat.getInstance})
        @validator.clearValuesFor({'choice2451' => Lib_Forms_Fields_ActComposite.getInstance})
        raise "verify panel #3 (a) validation" if not @validator.validate([{"choice2448" => Lib_Forms_Fields_Sat.getInstance},
                                             {"choice2449" => Lib_Forms_Fields_Sat.getInstance}])   
        raise "verify panel #3 (a) submit" if not @generalTools.wait("Congratulations, you're done!")                                          
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end 
  
  def test_panel3b
    Proc.new do
      begin
        @wizardTools.prevQuestion()
        raise "verify panel #3 (b) present" if not @wizardTools.waitForQuestion(:text => "What are your best SAT or ACT scores?")
        @validator.clearValuesFor({"choice2448" => Lib_Forms_Fields_Sat.getInstance})
        @validator.clearValuesFor({"choice2449" => Lib_Forms_Fields_Sat.getInstance})       
        raise "verify panel #3 (b) validation" if not @validator.validate({'choice2451' => Lib_Forms_Fields_ActComposite.getInstance})   
        raise "verify panel #3 (b) submit" if not @generalTools.wait("Congratulations, you're done!")
        raise "verify panel #3 (b) results" if not @wizardTools.verifyResults                                      
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end       
end