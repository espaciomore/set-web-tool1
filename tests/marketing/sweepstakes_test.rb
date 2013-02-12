class Tests_Marketing_SweepstakesTest < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/marketing/sweepstakes'
  end

  def testLoggedIn
    return false
  end
  
  def testSite
    "#{$target_server}/"  
  end
  
  def runTest  
    update_report("[Sweepstakes] Test that user can see Sweeptakes icon on the hompage",
                  test_bonus_button)
    update_report("[Sweepstakes] Test that user is redirected to the correct marketing page",
                  test_redirect)
  end
  
  def test_bonus_button
    Proc.new do 
      begin 
        raise "verify sweepstakes registration mesage" if not on_sweepstakes_icon.div( :class => 'reg').text=='Register Now'
        raise "verify sweepstakes chance to win mesage" if not on_sweepstakes_icon.div( :class => 'chanceToWin').text=='for a chance to win a'
        raise "verify sweepstakes grant mesage" if not on_sweepstakes_icon.div( :class => 'money').text=='$4,000'
        raise "verify sweepstakes scholarship mesage" if not on_sweepstakes_icon.div( :text => /scholarship!/).exists?
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end

  def test_redirect
    Proc.new do 
      begin 
        on_sweepstakes_icon.click
        raise "verify sweepstakes redirect to marketing page" if not @watir_helper.urlLike("#{$target_server}/2013/welcome")
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end
    
  def on_sweepstakes_icon
    @watir_helper.reset.link( :xpath => '//*[@id="sweepstakes"]' )
  end
end
