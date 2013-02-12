class Tests_Wizards_StudyAbroad_GridItemTest < Lib_Tools_GridViewItemSpecification
  def testGridItem(testName)   
    update_report("[#{testName}] Test that user can see that grid view item",
                  hasGridViewItem)         
    update_report("[#{testName}] Test that user can see that grid view item has image",
                  isImgLoaded)    
    update_report("[#{testName}] Test that user can see that grid view item has link to profile",
                  hasProfileLink) 
    update_report("[#{testName}] Test that user can see that grid view item has button to add to list",
                  hasAddToListLink)    
    update_report("[#{testName}] Test that user can see that grid view item has button to share",
                  hasShareButton)                                             
    update_report("[#{testName}] Test that user can see that grid view item has button to make favorite",
                  hasFavorite)   
    update_report("[#{testName}] Test that user can see that grid view item is displaying title",
                  hasTitle)   
    update_report("[#{testName}] Test that user can see that grid view item is displaying description",
                  hasDescription)  
    update_report("[#{testName}] Test that user can see that grid view item is displaying seasonal availiability",
                  hasActiveSeason)  
    update_report("[#{testName}] Test that user can see that grid view item is displaying location(s)",
                  hasLocation)        
    update_report("[#{testName}] Test that user can see that grid view item is displaying fit score",
                  hasFitScore)    
    update_report("[#{testName}] Test that user can see that grid view item can link to profile and then back to wizard",
                  canViewProfile)                
  end
  
  def description2
    return onGVI.div(:xpath => 'div[5]')
  end

  def description3
    return onGVI.div(:xpath => 'div[6]')
  end
      
  def hasDescription2
    super
  end   
  alias :hasActiveSeason :hasDescription2

  def hasDescription3
    super
  end  
  alias :hasLocation :hasDescription3
      
  def canViewProfile
    Proc.new do
      begin
        gridImage.click
        raise "verify redirect to profile" if not @watir_helper.urlLike("#{$target_server}/study-abroad")
        @watir_helper.reset.link(:text => /Back to search/).click
        raise "verify redirect to wizard" if not @watir_helper.urlLike("#{$target_server}/find/study-abroad")
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid 
    end
  end
end