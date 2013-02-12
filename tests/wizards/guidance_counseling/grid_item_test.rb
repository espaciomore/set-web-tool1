class Tests_Wizards_GuidanceCounseling_GridItemTest < Lib_Tools_GridViewItemSpecification
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
      
  def hasDescription2
    Proc.new do
      begin
        raise "verify location grammar is correct" if not description2.getText.match(/((((\w[A-Za-z ]+), ([A-Z][A-Z]))|(Online)))+/)!=nil       
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit 
    end    
  end
  alias :hasLocation :hasDescription2

  def hasDescription3
    Proc.new do
      begin
        raise "verify cost grammar is correct" if not description3.getText.match(/(\$(\d?\d?\d,)?\d\d(\/hr)?)+/)!=nil      
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit 
    end      
  end  
  alias :hasCost :hasDescription3
      
  def canViewProfile
    Proc.new do
      begin
        gridImage.click
        raise "verify redirect to profile" if not @watir_helper.urlLike( "#{$target_server}/guidance-counseling" )
        @watir_helper.reset.link(:text => /Back to search/).click
        raise "verify redirect to wizard" if not @watir_helper.urlLike( "#{$target_server}/find/guidance-counseling" )
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit
    end
  end
end
