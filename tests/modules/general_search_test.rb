class Tests_Modules_GeneralSearchTest < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/modules/general_search'
  end

  def testLoggedIn
    return false
  end
    
  def testSite
    return "#{$target_server}/search"
  end
  
  def runTest    
    update_report("[Header Search Module] Test that the user can search for anything through the search bar using the autocomplete functionality",
                  testSearchBar)
    update_report("[Header Search Module] Test that the user can search for any random (non existent) text through the search bar using the autocomplete functionality",
                  testRandomSearch)
    update_report("[Header Search Module] Test that the user can use the general search results for left menu options",
                  testLeftRailSearch)
  end
  
  private   
  
  def testSearchBar
    @watir_helper.goto testSite
    onHeader.text_field(:id => 'keyword')
    options = {'Noodlings Articles' => {'infographic' => '<span class="item-title"><strong>Infographic</strong>: Students Love Technology</span>'},
               'K-12' => {'La France Elementary'=>'<span class="item-title"><strong>La France Elementary</strong></span>'}, 
               'Tutoring' => {'yale tutors'=>'<span class="item-title"><strong>Yale Tutors</strong></span><span class="item-type"> in Tutoring</span>'}, 
               'Guidance Counseling' => {'dan edmonds' => '<span class="item-title"><strong>Dan Edmonds</strong></span>'}, 
               'College' => {'brenau university'=>'<span class="item-title"><strong>Brenau University</strong></span>'}, 
               'Study Abroad' => {'Chilean Universities Program'=>'<span class="item-title"><strong>Chilean Universities Program</strong> Valparaiso</span>'}, 
               'MBA' => {'Health Policy' => '<span class="item-title">Harvard University '}, 
               'Medical' => {'yale university'=>'<span class="item-title"><strong>Yale University</strong>'}, 
               'Law' => {'southwestern law school' => '<span class="item-title">Southwestern Law School'}, 
               'Graduate' => {'biological chemistry' => '<span class="item-title">University of California, Irvine '}} 
    
    searchItems = []
    _isValid = true
    options.each do |option, map|
      searchItems << option
      map.each do |searchText, item|
        begin
          @watir_helper.type searchText,0
          result = @generalTools.verifyText(item,10)
        rescue
          result = false
        end
        update_report("[Header Search Module] Test that the user can search for \"#{searchText}\" through the search bar using the autocomplete functionality",
                      result)       
        _isValid = _isValid and result       
        if !_isValid
          break
        end                                
      end
      if !_isValid
        break
      end       
    end
    
    return _isValid
  end

  def onHeader
    return @watir_helper.reset.div(:id => 'abstractHeader')
  end
    
  def testRandomSearch
    @watir_helper.goto testSite
    @watir_helper.reset.text_field(:id => 'keyword')
    words = [
             {:text => 'bard',:hasResults => true },
             {:text => 'comparative language studies', :hasResults => true },
             ]
    
    (1..3).each do |i|
      _rgValue = @generalTools.giveMeWord(rand(9)+5)
      words << {:text => _rgValue, :hasResults => false }    
    end
    
    searchItems = []
    _isValid = true
    words.each do |word|
      searchItems << word[:text]
      begin
        @watir_helper.reset.text_field(:id => 'keyword').type word[:text],0
        @watir_helper.reset.link(:xpath => '//*[@id="abstractHeaderSearchBox"]/a').click
        @watir_helper.urlLike("#{$target_server}/search?keyword=#{word[:text].gsub(/\s+/,'%20')}")
        _result = @generalTools.wait("All Results for <span>\"#{word[:text]}\"</span>",6)
        if word[:hasResults]
          _result = (_result and hasResults?)
        else
          _result = (_result and !hasResults?)
        end
      rescue
        _result = false
      end
      update_report("[Header Search Module] Test that the user can use the general search page for any random text like \"#{word[:text]}\"",
                    _result)     
      _isValid = (_isValid && _result)  
      if !_isValid
        break
      end                   
    end
    
    return _isValid
  end
  
  def testLeftRailSearch
    begin
      _isValid = true
      onLeftRight.ul.lis(10).each do |left_menu|
        @watir_helper.setElement(left_menu).link.click
        @watir_helper.urlLike "#{$target_server}/search?keyword="
        _isValid = _isValid and hasResults?
        update_report("[Header Search Module] Test that the user can use the general search results for left menu option: \"#{@watir_helper.setElement(left_menu).getText}\"",
                      _isValid)  
        if !_isValid
          break
        end      
      end
    rescue
      _isValid = false
    end
    
    return _isValid
  end
  
  def onLeftRight
    return @watir_helper.reset.div(:xpath => '//*[@id="sidebar-left"]')
  end
  
  def hasResults?
    return @watir_helper.reset.div(:xpath => '//*[@id="squeeze"]').divs(10).size>5
  end
end