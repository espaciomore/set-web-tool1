class Tests_Panels_AcademicTutoring_PanelTest < Lib_Tests_WizardAcceptanceTest

  def getWizardName
    return 'tutoring_panel'
  end

  def testSite
    return "#{$target_server}/find/tutoring"
  end

  def saveMyResults
    return 'Sign Up to Save Your Results'
  end

  def runTest
    #@browser.goto testSite
    clearAll
    
    update_report('[Tutoring Panel] Test that user can fill out the panel upon the following questions: "Subject"', 
                  test_subject)    
    update_report('[Tutoring Panel] Test that user can fill out the panel upon the following questions: "Location & Distance"', 
                  test_location_and_distance)                       
  end

  private

  def test_subject
    Proc.new do
      begin
        onSubject.text_field(:xpath => 'div[1]/div/input').typeBySet 'AP Calculus BC'
        @watir_helper.reset.link(:text => 'AP Calculus BC').click
        sleep 0.5
        onSubject.link(:xpath => 'div[2]/a[1]').click
        sleep 0.5
        onSubject.text_field(:xpath => 'div[1]/div[2]/input').type 'AP Calculus AB'
        @watir_helper.reset.link(:text => 'AP Calculus AB').click
        sleep 0.5
        raise "verify results for subject" if not hasResults?
        _subject = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _subject = false
      end
      _subject
    end
  end
  
  def test_location_and_distance
    Proc.new do
      begin
        onLocationAndDistance.text_field( :xpath => 'div[1]/input' )
        raise "verify default zip-code" if not @watir_helper.attribute_value(:value).include?('Zip or City and State')
        onLocationAndDistance.text_field( :xpath => 'div[1]/input' ).typeBySet '0'
        @generalTools.testSlider(/(left:\s)([0-9]+(\.[0-9]+)?%);/,'//*[@data-id="2005"]/div/a')
        @generalTools.wait('Please insert valid values',6)
        onLocationAndDistance.text_field( :xpath => 'div[1]/input' ).typeBySet 'New York City, NY'
        sleep 1
        @watir_helper.reset.link(:text => 'New York City, NY').click
        sleep 1
        @generalTools.testSlider(/(left:\s)([0-9]+(\.[0-9]+)?%);/,'//*[@data-id="2005"]/div/a')
        onLocationAndDistance.checkbox( :xpath => 'div[3]/input' ).set()
        raise "verify results for location and distance" if not hasResults?
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end
  
  def onSubject
    @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[1]/div[1]/div/div/div[1]/div/div')
  end
  
  def onLocationAndDistance
    @watir_helper.reset.div(:xpath => '//*[@id="quickPanelContent"]/div/div[2]/div[1]/div/div/div[1]/div')
  end
  
  def hasResults? timeout=10
    @wizardTools.verifyResults(timeout)
  end  
end