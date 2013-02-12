class Tests_Listings_ManageYourListingsTest < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::LISTINGS_REPORT_FOLDER_PATH + '/listings/manage_your_listing'
  end

  def testSite
    return "#{$target_server}/manage-your-listings"  
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
    update_report("[Manage Your Listings] Test that user can see the breadcrum composition is correct",
                  test_breadscrum)      
    update_report("[Manage Your Listings] Test that user can see the breadcrum composition is correct",
                  test_organization_list)                                     
    update_report("[Manage Your Listings] Test that user can see the list of listings is displaying",
                  test_listings_list)    
    update_report("[Manage Your Listings] Test that user can see the list of listings is displaying",
                  test_listing_search)                                            
  end  
  
  def test_breadscrum
    Proc.new do
      @generalTools.testBreadcrum( { :image => 'div[1]/a/img', :titles => ['Home','Manage Your Listings'] } )
    end
  end
    
  def test_organization_list
    Proc.new do
      begin
        raise "verify organization list" if not on_organizations.trows.size>=10
        _canSearch = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _canSearch = false
      end
      _canSearch
    end
  end
  
  def test_listings_list
    Proc.new do
      begin
        raise "verify listings list" if not on_listings.trows.size>=10
        _canSearch = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _canSearch = false
      end
      _canSearch      
    end
  end
    
  def test_listing_search
    Proc.new do
      begin
        @watir_helper.reset.text_field(:xpath => '//*[@id="manageListingContainer_filter"]/label/input').type "AP Calculus AB Individual Tutoring with Mathnasium"
        raise "verify search field" if not on_listings.trows.size==1
        _canSearch = true
      rescue 
        _canSearch = false
      end
      _canSearch
    end
  end
  
  def on_listings
    @watir_helper.reset.tbody( :xpath => '//*[@id="manageListingContainer"]/tbody' ).element
  end
  
  def on_organizations
    @watir_helper.reset.tbody( :xpath => '//*[@id="manageOrganizationContainer"]/tbody' ).element
  end
end