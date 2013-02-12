class Tests_Listings_CreateListingTest < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::LISTINGS_REPORT_FOLDER_PATH + '/create_listing'
  end

  def testSite
    return "#{$target_server}/create-a-listing"  
  end
  
  def testLoggedOut
    return false
  end   
  
  def isProvider
    return true
  end 
  
  def provider_user
    return "alex@noodle.org"
  end
  
  def provider_pwd
    return "noodle"  
  end
  
  def runTest 
    update_report("[Create Listing] Test that user can see the breadcrum composition is correct",
                  test_breadscrum)  
    update_report("[Create Listing] Test that user can see the correct header title",
                  test_header_title)              
    update_report("[Create Listing] Test that user can complete form section: About Your Listing",
                  test_about_your_listing)                
    update_report("[Create Listing] Test that user can complete form section: Cost",
                  test_cost)
    update_report("[Create Listing] Test that user can complete form section: About Your Listing",
                  test_about_your_listing2)     
    update_report("[Create Listing] Test that user can complete form is validating",
                  test_create_listing_button)                                                                            
  end  
  
  def test_breadscrum 
    Proc.new do
      @generalTools.testBreadcrum( { :image => 'div[1]/a/img', :titles => ['Home','Create a Listing'] } )
    end
  end
  
  def test_header_title
    Proc.new do
      begin
         raise "verify header title" if not on_profile_header.h1( :xpath => 'div[1]/h1' ).getText=='Create a new listing by filling out the form below'
         _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end
  
  def test_about_your_listing
    Proc.new do
      begin
        on_about_your_listing.select_list( :id => 'company' ).select 'NOODLE'
        raise "set private tutoring" if not on_about_your_listing.radio( :id => 'courseSessionFormat_0' ).set?
        raise "verify menu is hidden" if not on_about_your_listing.div( :xpath => 'div[2]/div[4]').style?('none')
        on_about_your_listing.radio( :id => 'courseSessionFormat_1' ).set
        sleep 0.5
        raise "verify menu is showing" if not on_about_your_listing.div( :xpath => 'div[2]/div[4]').attribute_value('style').size>=0
        on_about_your_listing.select_list( :id => 'courseSubject' ).select 'Spanish'
        _date = Time.now.strftime("%B %d, %Y").gsub(/\s0/, ' ')        
        raise "verify start date" if not on_about_your_listing.text_field( :id => 'courseStartDate' ).value.include?(_date)
        raise "verify end date" if not on_about_your_listing.text_field( :id => 'courseEndDate' ).value.include?(_date) 
        on_about_your_listing.select_list( :id => 'courseTests' ).select 'January 2013 SAT Spanish'
        on_about_your_listing.text_field( :id => 'courseListingTitle' ).type 'Test User Listing'
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end  
      _isValid
    end
  end
  
  def test_cost
    Proc.new do
      begin
        raise "verify rate is enabled" if not on_cost.text_field( :id => 'courseRate' ).attribute_value('class').include?('enabled')
        raise "verify per hour is set" if not on_cost.radio( :id => 'courseChargeType_1' ).set?
        on_cost.text_field( :id => 'courseRate' ).type '25.50'
        on_cost.checkbox( :id => 'rateUponRequest_1' ).set
        sleep 0.5
        raise "verify rate is disabled" if not on_cost.text_field( :id => 'courseRate' ).attribute_value('class').include?('disabled')
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end 
      _isValid
    end
  end

  def test_location
    Proc.new do
      begin
        on_location.text_field( :id => 'courseLocationAddress1' ).type '125 Street NW'
        on_location.text_field( :id => 'courseLocationAddress2' ).type 'Unit 1'
        on_location.text_field( :id => 'courseLocationCityState' ).typeBySet 'New York, NY'
        _textLink = @watir_helper.reset.link( :text => /New York, NY/)
        raise "verify autocomplete" if not _textLink.exists?
        _textLink.click
        on_location.text_field( :id => 'courseLocationZipCode' ).type '10001'
        on_location.checkbox( :id => 'courseLocationSettings_1' ).set
        on_location.radio( :id => 'onlineAvailability_3' ).set
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end 
      _isValid
    end
  end

  def test_about_your_listing2
    Proc.new do
      begin
        on_about_your_listing2.text_field( :id => 'courseDescription' ).type 'some description'
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end  
      _isValid
    end
  end

  def test_create_listing_button
    Proc.new do
      begin
        on_about_your_listing.text_field( :id => 'courseListingTitle' ).type ''
        on_create_listing_button.click
        sleep 0.5
        raise "form is not validating" if not @watir_helper.reset.find( :text => /Required: Please input a value/ ).exists?
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end  
      _isValid
    end
  end
        
  def on_profile_header
    @watir_helper.reset.div( :xpath => '//*[@id="profileHeader"]' )
  end
  
  def on_form
    @watir_helper.reset.div( :xpath => '//*[@id="entityEditForm"]' )
  end
  
  def on_about_your_listing
    on_form.div( :xpath => 'div[1]' )
  end
  
  def on_cost
    on_form.div( :xpath => 'div[2]' )
  end
  
  def on_location
    on_form.div( :xpath => 'div[3]' )  
  end  
  
  def on_about_your_listing2
    on_form.div( :xpath => 'div[4]' )
  end  
  
  def on_create_listing_button
    @watir_helper.reset.link( :xpath => '//*[@id="noodleFormsButton"]/a' )
  end
end