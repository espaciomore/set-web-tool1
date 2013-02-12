class Tests_Listings_ListsPageTest < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/listings/lists_page'
  end

  def testSite
    return "#{$target_server}/lists"
  end
  
  def testLoggedOut
    return false
  end   
  
  def isProvider
    return true
  end 
  
  def provider_user
    return "kdemoya@intellisys.com.do"
  end
  
  def provider_pwd
    return "welc0me"  
  end
  
  def runTest     
    update_report("[Lists Page] Test that user can see the breadcrum composition is correct",
                  testBreadscrum)   
    update_report("[Lists Page] Test that provider user can see the page /lists is displaying his listings",
                  testResults) 
    update_report("[Lists Page] Test that provider user can see the right items in the /lists page",
                  testItems)                                  
  end
  
  def testResults
    return onResults.size >= 1
  end
  
  def testBreadscrum
    return @generalTools.testBreadcrum( { :titles => ['Home','Lists'] } )
  end
  
  def testItems
    _items = {"high-schools" => '1', "colleges" => '2'}
    begin
      _isValid = true
      onResults.each do |item|
        _title = @watir_helper.setElement(item).link(:xpath => 'div[3]/h3/a').text
        _description = @watir_helper.setElement(item).div(:xpath => 'div[4]').text
        _isValid = _isValid && _items.has_key?(_title) && _description.include?(_items[_title])
      end
    rescue
      _isValid = false
    end
    
    return _isValid
  end
  
  def onResults
    return @watir_helper.reset.find(:xpath => '//*[@id="searchContent"]').divs(2)
  end
end