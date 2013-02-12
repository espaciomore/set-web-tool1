class Tests_CompanyProfiles_NoodleProsListingsTest < Lib_Tests_AcceptanceTest

  def getReportPath
    Config_Paths::REPORT_FOLDER_PATH + '/company_profiles/profile_listing_tab'
  end

  def testLoggedIn
    false
  end
  
  def testSite
    "#{$target_server}/pros/tutoring"  
  end
  
  def runTest
    update_report('[Listing] Test that user can see company profile is loading and listing tab is being displayed',
                  test_listing_tab)
    update_report('[Listing] Test that user can see that listing Tab is clickeable, items are appearing, and the 4 sort by options are in there',
                  test_items_sorting)
    update_report('[Listing] Test that user can use subject and location autocomplete ',
                  test_autocomplete)
  end

  private

  def test_listing_tab
    Proc.new do
      begin
        @watir_helper.urlLike "#{testSite}"
        raise "verify listing tab exists" if not @watir_helper.reset.link(:xpath => '//*[@id="center"]/ul/li[4]/p/a').exists?
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid 
    end
  end

  def test_items_sorting
    Proc.new do
      begin
        @watir_helper.reset.link(:xpath => '//*[@id="center"]/ul/li[4]/p/a').click
        sleep 10 # => to ensure items has loaded
        for i in 1..4
          raise "verify sorting method #{i.to_s} exists" if not @watir_helper.reset.link(:xpath => "//*[@id='listings']/div/div[1]/a[#{i}]").exists?
          raise "verify sorted results present" if not @watir_helper.reset.find(:xpath => '//*[@id="searchContent"]/li[1]').exists?
        end  
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid 
    end
  end

  def test_autocomplete
    Proc.new do
      begin
        @watir_helper.reset.text_field(:xpath => '//*[@id="listingSubjectsAutocomplete"]').typeBySet "Mathematics"
        sleep 1
        @watir_helper.reset.text_field(:xpath => '//*[@id="listingCityStateAutocomplete"]').typeBySet "New York City, NY"
        sleep 1
        raise "verify search results present" if !(@watir_helper.reset.div(:xpath => '//*[@id="searchContent"]').lis(3).size>=0)
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid 
    end
  end
end