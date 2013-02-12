class Tests_HomeSite_HomepageTest < Lib_Tests_AcceptanceTest
  def testSite
    return "#{$target_server}/"
  end
  
  def testName
    return "Noodle Homepage"  
  end

  def testLoggedIn
    return false
  end
    
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/homepage/noodle_homepage'
  end

  def runTest      
    update_report("[Noodle Beta Homepage] Test that visitors can see the carousel module is loading",
                  test_carousel)      
    update_report("[Noodle Beta Homepage] Test that visitors can see the marketing module is loading",
                  test_marketing)   
    update_report("[Noodle Beta Homepage] Test that visitors can see the press module is loading",
                  test_press)      
    update_report("[Noodle Beta Homepage] Test that visitors can see the feature walkthrough module is loading",
                  test_feature_walkthrough)             
  end
  
  def test_carousel
    Proc.new do
      begin
        raise "verify carousel content #1 title" if not on_carousel.h1( :text => 'Your Education Search, Simplified').exists?
        raise "verify carousel content #2 title" if not on_carousel.h1( :text => 'Learn Any Subject for Free').exists?
        raise "verify carousel content #3 title" if not on_carousel.h1( :text => 'Find the Answers You Need').exists?
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end

  def test_marketing
    Proc.new do
      begin
        _content_list = on_marketing.div.divs(4)
        raise "verify marketing content #1 title" if not @watir_helper.setElement(_content_list[0]).h3.text=='Find Schools'
        raise "verify marketing content #1 image" if not @watir_helper.setElement(_content_list[0]).image.loaded?
        raise "verify marketing content #2 title" if not @watir_helper.setElement(_content_list[1]).h3.text=='Get Help'
        raise "verify marketing content #2 image" if not @watir_helper.setElement(_content_list[1]).image.loaded?
        raise "verify marketing content #3 title" if not @watir_helper.setElement(_content_list[2]).h3.text=='Learn Online'
        raise "verify marketing content #3 image" if not @watir_helper.setElement(_content_list[2]).image.loaded?
        raise "verify marketing content #4 title" if not @watir_helper.setElement(_content_list[3]).h3.text=='Get Connected'
        raise "verify marketing content #4 image" if not @watir_helper.setElement(_content_list[3]).image.loaded?
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end

  def test_press
    Proc.new do
      begin
        raise "verify press module image loaded" if not on_press.image( :xpath => 'div/div[1]/div/center/img').loaded?
        _content_list = on_press.div( :xpath => '//*[@id="pressImageContainer"]/div').get_spans(6)
        raise "verify press content #1 image loaded" if not @watir_helper.setElement(_content_list[0]).link.image.loaded?
        raise "verify press content #2 image loaded" if not  @watir_helper.setElement(_content_list[1]).link.image.loaded?
        raise "verify press content #3 image loaded" if not  @watir_helper.setElement(_content_list[2]).link.image.loaded?
        raise "verify press content #4 image loaded" if not  @watir_helper.setElement(_content_list[3]).link.image.loaded?
        raise "verify press content #5 image loaded" if not  @watir_helper.setElement(_content_list[4]).link.image.loaded?
        raise "verify press content #6 image loaded" if not  @watir_helper.setElement(_content_list[5]).link.image.loaded?    
        _isValid = true  
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end
  
  def test_feature_walkthrough    
    Proc.new do
      begin
        _content_list = on_feature_walkthrough.div.divs(3)
        raise "verify feature #1 title" if not @watir_helper.setElement(_content_list[0]).h2.span.text=='We make it simple.'
        raise "verify feature #1 image" if not @watir_helper.setElement(_content_list[0]).image.loaded?
        raise "verify feature #2 title" if not @watir_helper.setElement(_content_list[1]).h2.span.text=='We remove the guesswork.'
        raise "verify feature #2 image" if not @watir_helper.setElement(_content_list[1]).image.loaded?
        raise "verify feature #3 title" if not @watir_helper.setElement(_content_list[2]).h2.span.text=='We give you the tools.'
        raise "verify feature #3 image" if not @watir_helper.setElement(_content_list[2]).image.loaded?
        _isValid = true  
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end
  
  def on_carousel
    @watir_helper.reset.div( :xpath => '//*[@id="headerCarousel"]' )
  end
  
  def on_marketing
    @watir_helper.reset.div( :xpath => '//*[@id="homePageContent"]/div[3]' )
  end
  
  def on_press
    @watir_helper.reset.div( :xpath => '//*[@id="homePageContent"]/div[5]' )
  end
  
  def on_feature_walkthrough
    @watir_helper.reset.div( :xpath => '//*[@id="homePageContent"]/div[6]' )
  end
end