class Tests_Wizards_K12_GridItemTest < Lib_Tools_GridViewItemSpecification
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
    update_report("[#{testName}] Test that user can see that grid view item is displaying location",
                  hasLocation)  
    update_report("[#{testName}] Test that user can see that grid view item is displaying grades",
                  hasGrades)       
    update_report("[#{testName}] Test that user can see that grid view item is displaying status",
                  hasStatus)    
    update_report("[#{testName}] Test that user can see that grid view item is displaying fit score",
                  hasFitScore)    
    update_report("[#{testName}] Test that user can see that grid view item can link to profile and then back to wizard",
                  canViewProfile)                
  end

  def description2
    return onGVI.div(:xpath => 'div[6]')
  end

  def description3
    return onGVI.div(:xpath => 'div[7]')
  end

  def hasDescription
    Proc.new do
      begin
        raise "verify location grammar is correct" if not description.getText.match(/(([0-9A-Za-z .]+), ([A-Z][A-Z]))+/)!=nil        
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit 
    end    
  end
  alias :hasLocation :hasDescription
    
  def hasDescription2
    Proc.new do
      begin
        raise "verify grades grammar is correct" if not description2.getText.match(/(Grades: (KG)|(PK)|[0-9] - [0-9][0-9]?)+/)!=nil        
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit 
    end   
  end  
  alias :hasGrades :hasDescription2

  def hasDescription3
    Proc.new do
      begin
        raise "verify status grammar is correct" if not description3.getText.match(/(((Public)|(Nonsectarian)|(Coeducational)|(Private non-profit)|(Roman Catholic))[, ]?)+/)!=nil       
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit 
    end     
  end    
  alias :hasStatus :hasDescription3
      
  def canViewProfile
    Proc.new do
      begin    
        gridImage.click
        raise "verify redirect to profile" if not @watir_helper.urlLike("#{$target_server}/k-12")
        @watir_helper.reset.link(:text => /Back to search/).click
        raise "verify redirect to wizard" if not @watir_helper.urlLike("#{$target_server}/k-12/search")
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit
    end     
  end
end