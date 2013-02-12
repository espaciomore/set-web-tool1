class Tests_Wizards_K12_WizardTest < Lib_Tests_WizardAcceptanceTest

  def getWizardName
    return 'k12_wizard'
  end
  
  def testUser
    return :k12
  end
  
  def testSite
    return "#{$target_server}/k-12/search"
  end
  
  def runTest
    sleep 5
    if !(@watir_helper.reset.find(:text => 'Characteristics').exists? || @watir_helper.reset.find(:text => 'Grade Level').exists?)  
      @wizardTools.startOver()       
      update_report('[K12 Wizard] Test panel on question: "Tell us a bit about what you\'re looking for..."', 
                    test_panel1)
      update_report('[K12 Wizard] Test panel on question: "Are you looking for any of these school characteristics?"', 
                    test_panel2)
      update_report('[K12 Wizard] Test panel on question: "Do you want your child to attend a religious affiliated school?"', 
                    test_panel3)
      test_panel4 # => report is implicit
      update_report('[K12 Wizard] Test panel on question: "What school size do you think is best for your child?"', 
                    test_panel5)
      update_report('[K12 Wizard] Test panel on question: "How much are you willing to pay up to for tuition (per year)?"', 
                    test_panel6)
      update_report('[K12 Wizard] Test panel on question: "Is it important to you that your child\'s school be diverse?"', 
                    test_panel7) 
      update_report("[K12 Wizard] Test that when user is filling out the k-12 wizard and user goes back to k-12 homepage then hits return to search, it lands on the last question",
                    testBackHome)             
    else
      Tests_Panels_K12_PanelTest.new( @generalTools ).runTest
    end
    
    testGVI( Tests_Wizards_K12_GridItemTest )
  end
  
  private
  
  def test_panel1
    Proc.new do 
      begin
        raise "verify first panel" if not @generalTools.wait("Tell us a bit about what you're looking for...", 15) 
        @watir_helper.reset.text_field(:name => 'choice287').typeBySet 'invalid'
        @wizardTools.submit()
        raise "verify location validation" if not @generalTools.wait('Please insert valid values',15)
        @watir_helper.reset.text_field(:name => 'choice287').typeBySet 'New Albany, IN'        
        @watir_helper.reset.anchor(:text => 'New Albany, IN').click
        sleep 2
        raise "verify location slider" if not @generalTools.testSlider(/(left:\s)([0-9]+(\.[0-9]+)?%);/)       
        @watir_helper.reset.checkbox(:id => 'choiceOfQuestion25690').set
        @watir_helper.reset.checkbox(:id => 'choiceOfQuestion25691').set
        @watir_helper.reset.checkbox(:id => 'choiceOfQuestion25692').set
        @wizardTools.submit()
        raise "verify results after checking great levels" if not hasResults?
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end 
  end
  
  def test_panel2
    Proc.new do 
      begin      
        raise "verify second panel" if not @generalTools.wait("Are you looking for any of these school characteristics?",15)  
        @watir_helper.reset.find(:xpath => '//*[@id="noodleRecommendsQuestionnairePlaceHolder"]/div[3]/a') 
        raise "verify apply button is disabled" if not @watir_helper.attr(:class).include?('disabled')
        @watir_helper.reset.checkbox(:id => 'choiceOfQuestion25693').set
        @watir_helper.reset.checkbox(:id => 'choiceOfQuestion25694').set
        @watir_helper.reset.checkbox(:id => 'choiceOfQuestion25695').set
        @watir_helper.reset.checkbox(:id => 'choiceOfQuestion25696').set
        @watir_helper.reset.checkbox(:id => 'choiceOfQuestion25697').set
        @watir_helper.reset.checkbox(:id => 'choiceOfQuestion25698').set
        @wizardTools.submit()
        raise "verify results after checking school characteristics" if not hasResults?
        _isValid = true        
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end
      
  def test_panel3
    Proc.new do
      begin
        raise "verify third panel" if not @generalTools.wait("Do you want your child to attend a religious affiliated school?", 15)
        @wizardTools.submit()
        raise "verify third panel validation" if not @generalTools.wait("Please insert valid values", 15)       
        @watir_helper.reset.radio(:id => 'choiceOfQuestion420').set
        @watir_helper.reset.select_list(:xpath => '//*[@id="wizardQuestion1"]/div/div[1]/div[1]/select').select('Catholic')
        @wizardTools.submit()
        raise "verify third panel submit has passed" if not @generalTools.wait("Would you want your child to attend a single sex school?", 15)
        _isValid = true        
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid  
    end
  end   
  
  def test_panel4
    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion414"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion25699"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion25700"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                     "Would you want your child to attend a single sex school?",
                     "What school size do you think is best for your child?")
  end

  def test_panel5
    Proc.new do
      begin
        raise "verify fifth panel" if not @generalTools.wait("What school size do you think is best for your child?", 15)
        @watir_helper.reset.select_list(:xpath => '//*[@id="wizardQuestion1"]/div/div/select').select("I have no preference") 
        @watir_helper.reset.find(:xpath => '//*[@id="noodleRecommendsQuestionnairePlaceHolder"]/div[3]/a/span/span/span').click
        raise "verify fifth panel submit has passed" if not @generalTools.wait('How much are you willing to pay up to for tuition (per year)?', 15)
        _isValid = true        
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end  

  def test_panel6
    Proc.new do
      begin
        raise "verify fifth panel" if not @generalTools.wait("How much are you willing to pay up to for tuition (per year)?", 15)
        raise "verify tuition slider" if not @generalTools.testSlider(/(left:\s)([0-9]+(\.[0-9]+)?%);/)
        @wizardTools.submit()
        raise "verify sixth panel submit has passed" if not @generalTools.wait("Is it important to you that your child's school be diverse?", 15)
        _isValid = true        
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end  
  
  def test_panel7
    Proc.new do
      begin
        raise "verify seventh panel" if not @generalTools.wait("Is it important to you that your child's school be diverse?", 15)
        @watir_helper.reset.select_list(:xpath => '//*[@id="wizardQuestion1"]/div/div/select').select("Yes, definitely") 
        @wizardTools.submit()
        raise "verify sixth panel submit has passed" if not @generalTools.wait("Congratulations, you're done!", 15)
        raise "verify results" if not hasResults?
        _isValid = true        
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end 

  def testBackHome
    Proc.new do
      begin
        @browser.a(:xpath, '//*[@id="pathBreadcrumb"]/div[2]/div[1]/a').click
        raise "verify redirect to k-12 landing page" if not @generalTools.waitUrl("#{$target_server}/k-12")
        raise "verify location value is loaded in k-12 landing page" if not @browser.element(:xpath, '//*[@id="location"]').attribute_value('value')=='New Albany, IN'
        raise "verify slider in k-12 landing page" if not @generalTools.testSlider(/(left:\s)([0-9]+(\.[0-9]+)?%);/)
        raise "verify grade is selected in k-12 landing page" if not @browser.element(:xpath, '//*[@id="grade"]/option[2]').attribute_value('selected')
        @browser.a(:xpath, '//*[@id="getResults"]').click
        raise "verify redirect to wizard from k-12 landing page" if not @generalTools.waitUrl("#{$target_server}/k-12/search",5)
        _isValid = true        
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end

  def hasResults? timeout=10
    return @wizardTools.verifyResults(timeout)
  end 
end  
