class Tests_Wizards_TestPrep_GridItemTest < Lib_Tools_GridViewItemSpecification
  def testGridItem(testName)   
    update_report("[#{testName}] Test that user can see that grid view item",
                  hasGridViewItem)     
    update_report("[#{testName}] Test that user can see that grid view item has image",
                  isImgLoaded)    
    update_report("[#{testName}] Test that user can see that grid view item has tutor badge image",
                  hasBadgeImage)                        
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
                  true) if hasDescription
    update_report("[#{testName}] Test that user can see that grid view item is displaying location(s)",
                  true) if hasLocation
    update_report("[#{testName}] Test that user can see that grid view item is displaying tutoring cost",
                  true) if hasCost        
    update_report("[#{testName}] Test that user can see that grid view item is displaying fit score",
                  hasFitScore)    
    update_report("[#{testName}] Test that user can see that grid view item can link to profile and then back to wizard",
                  canViewProfile)                
  end
  
  def description
    _index = !badgeImage.exists? ? '5':'6'
    return onGVI.div(:xpath => "div[#{_index}]")
  end
  
  def description2
    _index = !badgeImage.exists? ? '5':'6'
    return onGVI.div(:xpath => "div[#{_index}]")
  end
  
  def description3
    _index = !badgeImage.exists? ? '5':'6'
    return onGVI.div(:xpath => "div[#{_index}]")
  end
    
  def hasDescription2
    _location = description2.getText
    return _location.match(/((((\w[A-Za-z ]+), ([A-Z][A-Z]))|(Online)))+/)!=nil
  end
  alias :hasLocation :hasDescription2

  def hasDescription3
    return description3.getText.match(/(\$(\d?\d?\d,)?\d\d(\/hr)?)+/)!=nil
  end  
  alias :hasCost :hasDescription3
      
  def canViewProfile
    gridImage.click
    profile = @watir_helper.urlsLike( ["#{$target_server}/pros/tutoring", "#{$target_server}/tutoring", "#{$target_server}/small-group"] )
    @watir_helper.reset.link(:text => /Back to search/).click
    wizard = @watir_helper.urlLike "#{$target_server}/find/test-prep"
    return profile && wizard
  end
end