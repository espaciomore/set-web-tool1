class Tests_Noodlings_NoodlingPageTest < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::NOODLINGS_REPORT_FOLDER_PATH + '/noodlings'
  end
  
  def testSite
    return "#{$target_server}/noodlings"
  end
  
  def testLoggedOut
    return false
  end
  
  def runTest
    @categories = ['All','K-12', 'Tutoring', 'Guidance Counseling', 'College', 'Study Abroad', 'MBA', 'Medical', 'Law', 'Graduate']
    
    update_report("[Noodlings] Test that user can control content through the categories navigation",
                  test_categories)
    update_report("[Noodlings] Test that user can also control content through the topics navigation",
                  test_topics)  
    update_report("[Noodlings] Test that user can see the expert voices",
                  test_expert_voices)                                                          
  end
  
  def test_categories
    Proc.new do
      begin
        _categories = @categories.join(' ')
        onCategories.lis(10)[1..9].each do |category|
          @watir_helper.setElement(category).link.click
          _vertical = @watir_helper.setElement(category).link.span.getText
          raise "verify noodlings for #{_vertical}" if not _categories.include?(_vertical) and hasResults?
          #@watir_helper.setElement(category).link.click
        end
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end

  def test_topics
    Proc.new do
      begin
        onTopics.lis(3)[1..2].each do |topic|
          @watir_helper.setElement(topic).link.click
          _topic = @watir_helper.setElement(topic).link.span.getText
          raise "verify noodlings for #{_topic}" if not hasResults?
          #@watir_helper.setElement(topic).link.click
        end
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end

  def test_expert_voices
    Proc.new do
      begin
        raise "verify expert voice module" if not onExpertVoices.divs(4).size>=3
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false  
      end
      _isValid
    end
  end
        
  def onCategories
    @watir_helper.reset.ul(:xpath => '//*[@id="noodlingCategories"]/ul')
  end

  def onTopics
    @watir_helper.reset.ul(:xpath => '//*[@id="noodlingTopics"]/ul')
  end
  
  def onExpertVoices
    @watir_helper.reset.div(:xpath => '//*[@id="noodlingsExpertListModule"]/div')
  end  
  
  def hasResults?    
    sleep 2
    @watir_helper.reset.ul(:xpath => '//*[@id="postList"]').lis(5).size>=1
  end
end