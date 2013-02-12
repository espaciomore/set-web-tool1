class Tests_Wizards_Law_GridItemTest < Lib_Tools_GridViewItemSpecification
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
                  hasLocation)  
    update_report("[#{testName}] Test that user can see that grid view item is displaying seasonal availiability",
                  hasDescription)         
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
    return description2.getText.match(/(([A-Za-z .]+), ([A-Z][A-Z]))+/)!=nil
  end  
  alias :hasLocation :hasDescription2

  def hasDescription3
    return description3.getText.match(/[\w ,:.'-\/]+/)!=nil
  end    
  alias :hasDescription :hasDescription3
      
  def canViewProfile
    gridImage.click
    profile = @watir_helper.urlLike "#{$target_server}/graduate"
    @watir_helper.reset.link(:text => /Back to search/).click
    wizard = @watir_helper.urlLike "#{$target_server}/find/law"
    return profile && wizard
  end
end