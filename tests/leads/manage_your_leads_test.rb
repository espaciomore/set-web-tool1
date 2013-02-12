class Tests_Leads_ManageYourLeadsTest < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::LISTINGS_REPORT_FOLDER_PATH + '/listings/manage_your_leads'
  end

  def testSite
    return "#{$target_server}/manage-your-leads"  
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
    @watir_helper.reset.link(:xpath => '//*[@id="manageNavigation"]/span[2]/a').click       
    @watir_helper.urlLike testSite    
    update_report("[Manage Your Listings] Test that user can see the breadcrum composition is correct",
                  testBreadscrum)             
    update_report("[Manage Your Listings] Test that user can see the list of listings is displaying",
                  testResults)      
    update_report("[Manage Your Listings] Test that user can see the list of listings can be sorted",
                  testSorting)   
    update_report("[Manage Your Listings] Test that user can see the list of listings is displaying",
                  testSearch)                                           
  end  
  
  def testResults
    return onResults.trows.size>=2
  end
  
  def testSearch
    begin
      @watir_helper.reset.text_field(:xpath => '//*[@id="manageLeadsContainer_filter"]/label/input').type "SAT US History Individual Tutoring with Bright Ideas Tutoring"
      _canSearch = onResults.trows.size==1
    rescue 
      _canSearch = false
    end
    
    return _canSearch
  end
  
  def testSorting
    begin
      _canSort = true
      _listings = []
      onResults.trows.each do |trow|
        _listings << @watir_helper.setElement(trow).link(:xpath => 'td[4]/a').getText
      end
      @watir_helper.reset.find(:xpath => '//*[@id="manageLeadsContainer"]/thead/tr/th[3]').click
      @watir_helper.reset.find(:xpath => '//*[@id="manageLeadsContainer"]/thead/tr/th[3]').click
      sleep 2
      _listings.reverse!
      _index = 0
      onResults.trows.each do |trow|
        _canSort = (_canSort and _listings[_index]==@watir_helper.setElement(trow).link(:xpath => 'td[4]/a').getText)
        _index += 1
      end    
    rescue
      _canSort = false
    end
    
    return _canSort
  end
  
  def onResults
    if !@RT
      @RT = @watir_helper.reset.tbody(:xpath => '//*[@id="manageLeadsContainer"]/tbody').element
    end
    return @watir_helper.setElement(@RT)
  end
  
  def testBreadscrum
    return @generalTools.testBreadcrum( { :image => 'div[1]/a/img', :titles => ['Home','Manage Your Leads'] } )
  end  
end