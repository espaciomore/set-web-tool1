class Lib_Tools_GridViewItemSpecification  
  
  def initialize(tools)
    @browser = tools.browser
    @generalTools = tools
    @watir_helper = tools.watir_helper
    @wizardTools = tools.wizardTools
    @report = tools.report  
    @context = @watir_helper.element
  end
  
  def testGridItem(testName)   
    raise NotImplementedError
  end
  
  def wait _text
    return (@report.overallResult=='PASSED' ? @generalTools.wait(_text, Configuration::WAIT_TIMEOUT) : false)
  end  
  
  def onGVI item=nil
    if item!=nil
      @context = item
    end
    return @watir_helper.setElement(@context)
  end
  
  def gridImage
    return onGVI.image(:xpath => 'div[@class="GridImageComponent"]/a/img')
  end
  
  def badgeImage
    return onGVI.image(:xpath => 'div[@class="GridBadgeComponent"]/img')
  end    
  
  def viewProfile
    return onGVI.link(:xpath => 'div[@class="communityOptions"]/div[1]/div[1]/a')
  end
  
  def addToList
    return onGVI.div(:xpath => 'div[@class="communityOptions"]/div[1]/div[2]')
  end
  
  def shareButtonX
    return onGVI.div(:xpath => 'div[@class="communityOptions"]/div[1]/div[3]')
  end

  def favorite
    return onGVI.div(:xpath => 'div[@class="communityOptions"]/div[1]/div[4]')
  end
  
  def onTitle
    return onGVI.h3(:xpath => 'div[@class="GridTitleComponent"]/h3')
  end
  
  def description
    return onGVI.div(:xpath => 'div[@class="GridTextComponent bold"]')
  end

  def description1
    return onGVI.div(:xpath => 'div[@class="GridTextComponent"]')
  end
    
  def description2
    return onGVI.div(:xpath => 'div[@class="GridTextComponent"]')
  end
  
  def description3
    return onGVI.div(:xpath => 'div[7]')
  end
  
  def fitScore
    return onGVI.span(:xpath => 'div[@class="GridInnerContainer bottom "]/div[1]/div/div/span[1]')
  end
  
  def hasGridViewItem
    Proc.new do
      begin
        raise "verify grid view item exists" if not onGVI.waitOnEval('exists? && visible?',6)
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit
    end      
  end
  
  def isImgLoaded
    Proc.new do
      begin
        raise "verify avatar image is loaded" if not gridImage.loaded?
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit
    end     
  end  
  
  def hasBadgeImage  
    Proc.new do
      begin
        raise "verify badge image is loaded" if !(badgeImage.exists? ? badgeImage.loaded? : true) # => it can be a test prep tutoring
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit
    end      
  end
      
  def hasProfileLink
    Proc.new do
      begin
        raise "verify link to profile exists" if not viewProfile.exists?
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit
    end    
  end  

  def hasAddToListLink
    Proc.new do
      begin
        raise "verify link to lists exists" if not addToList.exists?
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit
    end    
  end   
  
  def hasShareButton
    Proc.new do
      begin
        _shareTitle = shareButtonX.attribute_value(:title)
        _title = onTitle.link.getText
        raise "verify social network share button" if !(_shareTitle==_title)
        #_validOverlay = _validOverlay and @watir_helper.reset.find(:id => /_commentCanvas/).div(:text => _title).exists?
        _validOverlay = true
      rescue
        _validOverlay = false
      end
      _validOverlay
    end
  end
  
  def hasFavorite
    Proc.new do
      begin
        raise "verify button to favorite exists" if not favorite.exists? # => onGVI.attribute_value(:class).include?( "favorited" )
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit
    end     
  end
  
  def hasTitle
    Proc.new do
      begin
        raise "verify title grammar is correct" if not onTitle.link.getText.match(/[\w ,:.'\/]+/)!=nil
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit
    end     
  end
  
  def hasDescription
    Proc.new do
      begin
        raise "verify description grammar is correct" if not description.getText.match(/[\w ]+/)!=nil
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit
    end     
  end

  def hasDescription1
    Proc.new do
      begin
        raise "verify description1 grammar is correct" if not description1.getText.match(/[\w ]+/)!=nil
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit
    end    
  end
  
  def hasDescription2
    Proc.new do
      begin
        raise "verify description2 grammar is correct" if not description2.getText.match(/[\w ,]+/)!=nil
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit
    end    
  end
    
  def hasDescription3
    Proc.new do
      begin
        raise "verify description3 grammar is correct" if not description3.getText.match(/[\w ,;]+/)!=nil
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit
    end     
  end  
  
  def hasFitScore
    Proc.new do
      begin
        raise "verify fitscore exists" if not fitScore.exists?
        _exit = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _exit = false
      end
      _exit
    end      
  end
  
  def canViewProfile
    raise NotImplementedError
  end
  
  def update_report(description, reason)
    @generalTools.update_report(description, reason)   
  end  
end