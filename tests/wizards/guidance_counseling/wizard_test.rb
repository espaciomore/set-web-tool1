class Tests_Wizards_GuidanceCounseling_WizardTest < Lib_Tests_WizardAcceptanceTest

  def getWizardName
    return 'guidance_counseling_wizard'
  end
  
  def testUser
    return :guidancecounseling
  end

  def testSite
    return "#{$target_server}/find/guidance-counseling"
  end
  
  def runTest
    @wizardTools.startOver()

    update_report('['+getFriendlyName+'] Test that the wizards loads concurrently and quickly',
                  @watir_helper.reset.find(:xpath => '//*[@class="wizardPointer"]').exists?)  
                      
    update_report('[Guidance Counseling Wizard] Testing validation for "What would you like guidance counseling for?"',
                  test_panel1)       
                   
    testCheckButtons([{:selector => :xpath, :value => '//*[@id="choiceOfQuestion2503"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2504"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => false},
                      {:selector => :xpath, :value => '//*[@id="choiceOfQuestion2505"]/a/table/tbody/tr/td[1]/div', :hasResults => true, :last => true}],
                     "How much does cost matter?",
                     "Congratulations, you're done!")    

    update_report('[Guidance Counseling Wizard] Verifying that the wizard generated some results', 
                  test_results)
    
    testGVI( Tests_Wizards_GuidanceCounseling_GridItemTest )
  end
  
  def test_panel1
    Proc.new do
      begin
        raise "verify first panel present" if not @wizardTools.waitForQuestion(:text => "What would you like guidance counseling for?")
        raise "verify first panel select option" if not @generalTools.wait('Special Needs/Learning Disabilities')
        on_reason_select.select 'College'
        on_location.type '0'
        on_apply_button.click
        sleep 0.5
        raise "verify location with validation" if not @watir_helper.reset.find( :text => 'Please insert valid values').visible?
        on_location.type 'New Albany, IN'
        sleep 0.5
        @watir_helper.reset.link( :text => 'New Albany, IN' ).click
        on_apply_button.click
        raise "verify first panel submit" if not @generalTools.wait("How much does cost matter?", 15)
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
  
  def on_reason_select
    @watir_helper.reset.select_list( :xpath => '//*[@id="wizardQuestion1"]/div/div/select' )
  end
  
  def on_location
    @watir_helper.reset.text_field( :name => 'choice2501' )
  end
  
  def on_apply_button
    @watir_helper.reset.span( :text => 'Apply' )
  end
end
