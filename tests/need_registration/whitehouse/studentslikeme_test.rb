class Tests_NeedRegistration_Whitehouse_StudentslikemeTest < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/whitehouse_project/students_like_me'
  end
  
  def testLoggedIn
    return false
  end
  
  def testSite
    if not @test_site
      return "#{$target_server}/"
    end
    @test_site
  end
  
  def register_user
    'noodle.test.whp@gmail.com'
  end
  
  def runTest  
    @test_site = "#{$target_server}/college/studentslikeme"  
    update_report("[Whitehouse Project] Test that the user can login succesfully!",
                   homepage_register_new_user)     
    update_report("[Whitehouse Project] Test that the user can go pass the landing page then to the wizard",
                   test_landing_page)
    update_report("[Whitehouse Project] Test that the user can read \"Students Like Me Survey | College Discovery Search | Noodle Education\" on the page title",
                   test_page_title)
    # bug_found 10/24/2012                    
    update_report("[Whitehouse Project] Test that the user can go through the wizard following the right question flow with pauses and rewards",
                  test_wizard)
    update_report("[Whitehouse Project] Test that the user is redirected to the dashboard where user will see the results",
                  test_rewards)       
    update_report("[Whitehouse Project] Test that user can NOT see a Finish Quiz button on the left-side bar",
                  test_no_finish_quiz)
    update_report("[Whitehouse Project] Test that user can see that the center content has been loaded and it matches the recommendations after the whitehouse project wizard",
                  test_center_content)   
    update_report("[Whitehouse Project] Test that user can see that the college wizard content has been loaded and it matches the recommendations after the whitehouse project wizard",
                  test_college_search_content)                         
    removeUser()                         
  end
  
  private  
    
  def test_landing_page
    Proc.new do
      begin    
        @watir_helper.goto testSite
        # user must get started
        _wButton = @watir_helper.reset.abutton(:xpath => '//*[@id="startWizardButton"]')
        _wButton.clickOn
        raise "verify whitehouse wizard visible" if not onWizard.waitOnEval("style?('block')")
        delay
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end

  def test_page_title
    Proc.new do
      begin
        raise "verify page title" if !(@watir_helper.pageTitle == 'Students Like Me Quiz | College Discovery Search | Noodle Education')
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end
    
  def test_wizard
    Proc.new do
      begin      
        _answered = 1
        _previous = nil
        getStreaks.each do |streak|        
          streak[:streak].each do |question|          
            onPanel question[:index]
            raise "verify question #{question[:index]} present" if !((getTitle.include?(question[:title]) && (answered==_answered) && isChoiceImgLoading) || _answered==15)
            
            if(_answered==2)
              onPanel(question[:index]).div(:class => 'tk-museo-sans goBack navigationLink').click
              onPanel(_previous)
              raise "verify previous image greyed out" if not getChoice.div(:class => 'pictureContainer').style("background-color").include?("rgba(204, 204, 204, 1)")
              onPanel(_previous)
              getChoice.click                    
            end    
            
            if (_answered==9)
              # click on Finish Later
              onPanel(question[:index]).div(:class => 'tk-museo-sans finishLater navigationLink').click
              raise "verify redirect to home" if not @watir_helper.urlLike("#{$target_server}/home")
              raise "verify user home banner badges present" if not testBannerButtons
              raise "verify user home finish-quiz button" if not testFinishQuizButton
                # should land on the next unanswered question                 
            end 
            
            _answered += 1       
            #if (_answered == 19)
              # user will see a message "Great job. You're almost done!"
            #  _answered += 1 
            #end      
            
            onPanel question[:index]
            getChoice.click 
            _previous = question[:index]  
          end
          
          if (streak[:index]<2)
            _panel = streak[:index]
            getPauses[_panel][:id]
            raise "verify pause image loaded" if !(@watir_helper.waitOnEval("\"#{onPanel(getPauses[_panel][:id]).attribute_value('class')}\".include?('active')") and onPanel(getPauses[_panel][:id]).image(:xpath => 'div/div[1]/img').loaded?)
            onPanel(getPauses[_panel][:id]).span(:text => 'Continue').click
          end
        end
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end
  
  def getStreaks
   return [{:streak => [
                     {:title=>"In a bookstore, you'd buy:",:index=>'qid_6', :finishLater => false},
                     #{:title=>"Mac or PC?",:index=>'qid_7', :finishLater => false},
                     {:title=>"Which locker room do you use at the gym?",:index=>'qid_2', :finishLater => false},
                     {:title=>"It's Friday night, you're:",:index=>'qid_3', :finishLater => false},
                     {:title=>"Which class would you pick?",:index=>'qid_4', :finishLater => false},
                     {:title=>"What about these?",:index=>'qid_5', :finishLater => false},
                     ],
           :index => 0},
           {:streak => [
                     #{:title=>"Saturday afternoon, you're",:index=>'qid_1', :finishLater => true},
                     {:title=>"You're in school, you'd rather be working on:",:index=>'qid_9', :finishLater => true},
                     #{:title=>"Your favorite season is:",:index=>'qid_10', :finishLater => true},
                     {:title=>"It's game day. Where are you?",:index=>'qid_11', :finishLater => true},
                     {:title=>"Your parent wants to see your report card.",:index=>'qid_12', :finishLater => true},
                     {:title=>"You're a college freshman, what are you doing?",:index=>'qid_13', :finishLater => true},
                     {:title=>"You've graduated...what do you wear to work?",:index=>'qid_14', :finishLater => true},
                     #{:title=>"How do you chat with your friends?",:index=>'qid_15', :finishLater => true},
                     {:title=>"Finals are a week away. You are:",:index=>'qid_16', :finishLater => true},
                     {:title=>"Dinner time! You pick:",:index=>'qid_17', :finishLater => true},
                     ],
           :index => 1},
           {:streak => [
                     {:title=>"When it comes to sports, you:",:index=>'qid_18', :finishLater => true},
                     {:title=>"Your personal style is:",:index=>'qid_19', :finishLater => true},
                     #{:title=>"Your room looks:",:index=>'qid_20', :finishLater => true},
                     {:title=>"You want those expensive concert tickets. You:",:index=>'qid_21', :finishLater => false},
                     ],
           :index => 2}]
  end
  
  def getPauses
    if not @pause
      @pause = [{:image => '/misc/images/recommendation_engine/medal_big.png', :id => 'triggerPause_5'},
                {:image => '/misc/images/recommendation_engine/talk_bubble.png', :id => 'triggerPause_12'}
                ]
    end 
    return @pause
  end
  
  def onBanner
    return @watir_helper.reset.div(:xpath => '//*[@id="container"]/div[3]')  
  end
  
  def onSideBar
    return @watir_helper.reset.div(:xpath => '//*[@id="sidebar-left"]')  
  end
  
  def testBannerButtons
    begin
      onBanner.waitOnEval("style?('display: block;')")
      _firstReward = (onBanner.span(:class => 'medalImageContainer').exists?)
      _secondReward = !(onBanner.span(:class => 'trophyImageContainer').exists?)
      _title = onBanner.link(:xpath => '//*[@id="shareRecomendationsOnFacebookButton"]').title
      isValid = _title.include?('The fun way to search for colleges - brought to you by Noodle and the White House.')
      isValid = (isValid and _firstReward and _secondReward)    
    rescue
      isValid = false  
    end
    
    return isValid  
  end
  
  def testFinishQuizButton
    begin
      onSideBar.abutton(:id => 'returnToQuiz').click
      isValid = @watir_helper.urlLike(testSite)
    rescue
      isValid = false
    end
    return isValid
  end

  def test_no_finish_quiz
    Proc.new do
      begin
        raise "verify finish-quiz button not present" if onSideBar.span(:text => 'Finish Quiz').exists?
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid   
    end
  end

  def test_rewards 
    Proc.new do
      begin
        raise "verify redirect to home" if not @watir_helper.urlLike("#{$target_server}/home")
        raise "verify banner present" if not onBanner.waitOnEval("style?('block')")
        raise "verify first reward present" if not onBanner.span(:class => 'medalImageContainer').exists?
        raise "verify second reward present" if not onBanner.span(:class => 'trophyImageContainer').exists?
        raise "verify third reward present" if not onBanner.span(:class => 'shieldImageContainer').exists?
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid 
    end  
  end
       
  def test_center_content
    Proc.new do
      begin        
        raise "verify center content present" if not onCenter.exists?
        _sections = getCenterContent   
        _index = 0
        _sections.each do |element|
          if element.attribute_value(:class).include?('big')
            itemTitle = getRecommendation[_index][:title]
            raise "verify item #{_index} title: #{itemTitle}" if not @watir_helper.setElement(element).h3( :text => "#{itemTitle}" ).exists?
            # get list of reasons
            reasons = []
            @watir_helper.setElement(element).ul(:xpath => 'div[2]/div/ul').lis(5).each do |li|
              reasons << (li.text)
            end
            raise "verify item #{_index} reasons" if not reasons.join.include?(getRecommendation[_index][:reasons].join)
          else
            itemName = getRecommendation[_index][:name]
            raise "verify item #{_index} name" if not @watir_helper.setElement(element).h2(:xpath => 'a/div/div[2]/h2').text.include?(itemName)
            itemLocation = getRecommendation[_index][:location]
            raise "verify item #{_index} location" if not @watir_helper.setElement(element).p(:xpath => 'a/div/div[2]/p[1]').text.include?(itemLocation)
            itemOfferings = getRecommendation[_index][:offerings].join(', ')
            raise "verify item #{_index} offerings" if not @watir_helper.setElement(element).p(:xpath => 'a/div/div[2]/p[3]').text.include?(itemOfferings)        
            # get list of also known for characteristics
            reasons = []
            @watir_helper.setElement(element).ul(:xpath => 'a/div/div[2]/ul').lis(3).each do |li|
              reasons << (li.text)
            end
            raise "verify item #{_index} also known as" if not reasons.join.include?(getRecommendation[_index][:alsoknownfor].join) 
          end
          _index += 1
        end
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid 
    end
  end  

  def test_college_search_content
    Proc.new do
      begin
        @watir_helper.goto("#{$target_server}/find/college")
        raise "verify college wizard default results loaded" if not @wizardTools.verifyResults()
        _sections = getSearchContent            
        raise "verify results greater than 10" if not _sections.size > 10
        _index = 1
        _sections.each do |element|  
          raise "verify item #{_index} present" if not @watir_helper.setElement(element).find( :xpath => 'div[4]/h3/a').exists?
          _title = @watir_helper.setElement(element).link( :xpath => 'div[4]/h3/a').text
          raise "verify item #{_index} title: #{word}" if not _title==getRecommendation[_index][:name] 
          #getRecommendation[_index][:name].split(' ').each do |word|            
          #  raise "verify item #{_index} title: #{word}" if !(word!='of' and word!='the' and _title.include?(word))
          #end
          _index += 1
          break if _index > 10
        end
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid 
    end
  end  
  
  def getRecommendation
    if not @recommendations
      @recommendations = [{:title => "What college will you attend?", 
                           :reasons => ['Budget', 'Academic Interests', 'Social Life', 'Location', 'School Size']},
                          {:name => "University of Georgia", 
                           :location => "Athens, GA", 
                           :offerings => ['social activities', 'great facilities', 'vegetarian food'], 
                           :alsoknownfor => ['being prestigious','intellectual stimulus','a beautiful campus']},
                          {:name => "Michigan State University",
                           :location => "East Lansing, MI",
                           :offerings => ['social activities', 'great facilities', 'vegetarian food'],
                           :alsoknownfor => ['being prestigious', 'intellectual stimulus', 'a beautiful campus']},
                          {:name => "James Madison University",
                           :location => "Harrisonburg, VA",
                           :offerings => ['social activities', 'great facilities', 'vegetarian food'],
                           :alsoknownfor => ['being prestigious', 'intellectual stimulus', 'a beautiful campus']}, 
                          {:name => "University of Kansas",
                           :location => "Lawrence, KS",
                           :offerings => ['social activities', 'great facilities', 'political discourse'],
                           :alsoknownfor => ['being prestigious', 'intellectual stimulus', 'a beautiful campus']},
                          {:name => "Arizona State University",
                           :location => "Tempe, AZ",
                           :offerings => ['social activities', 'great facilities', 'greek life'],
                           :alsoknownfor => ['being prestigious', 'great weather', 'being large']},   
                          {:name => "University of Connecticut",
                           :location => "Storrs, CT",
                           :offerings => ['social activities', 'great facilities'],
                           :alsoknownfor => ['being prestigious', 'intellectual stimulus', 'being large']},  
                          {:name => "University of North Carolina at Chapel Hill",
                           :location => "Chapel Hill, NC",
                           :offerings => ['social activities', 'great facilities', 'political discourse'],
                           :alsoknownfor => ['being prestigious', 'intellectual stimulus', 'a beautiful campus']},       
                          {:name => "University of Southern California",
                           :location => "Los Angeles, CA",
                           :offerings => ['social activities', 'great facilities', 'greek life'],
                           :alsoknownfor => ['being prestigious', 'intellectual stimulus', 'a beautiful campus']},   
                          {:name => "University of Central Florida",
                           :location => "Orlando, FL",
                           :offerings => ['social activities', 'great facilities', 'greek life'],
                           :alsoknownfor => ['being prestigious', 'intellectual stimulus', 'a beautiful campus']}, 
                          {:name => "University of Arizona",
                           :location => "Tucson, AZ",
                           :offerings => ['social activities', 'great facilities', 'greek life'],
                           :alsoknownfor => ['being prestigious', 'intellectual stimulus', 'a beautiful campus']},                                                                                                                    
                          ]
    end
    return @recommendations
  end  

  def onCenter(cPath='//*[@id="squeeze"]')
    return @watir_helper.reset.div(:xpath => cPath)
  end
  
  def getCenterContent(ccPath='ul/li/ul')
    return onCenter.ul(:xpath => ccPath).lis(11)
  end 

  def getSearchContent(ccPath='//*[@id="searchContent"]')
    @watir_helper.reset.find( :xpath => ccPath ).divs(11)
  end 
     
  def onWizard(wPath='//*[@id="wizardContainer"]')
    return @watir_helper.reset.div(:xpath => wPath)  
  end
  
  def onPanel(_index=nil)
    if _index!=nil
      @panel = onWizard.li(:xpath => "//*[@id=\"#{_index}\"]")
    end
    @watir_helper.setElement(@panel.element).waitOnEval("@element.attribute_value('class').include?('active')", 0.5)
    return @panel
  end
  
  def getTitle
    return onPanel.h1(:xpath => "div/h1").text
  end
  
  def getChoice(_index=1)
    return onPanel.li(:xpath => "ul/li[#{_index}]")
  end
  
  def isChoiceImgLoading(ipath='div/div/img')
    return getChoice.image(:xpath => ipath).loaded?
  end
  
  def answered(lPath='//*[@id="wizardContainer"]/div/div[1]/ul')
    return onWizard.ul(:xpath => lPath).lis(20).size
  end
  
  def unAnswered(lPath='//*[@id="wizardContainer"]/div/div[2]/ul')
    return onWizard.ul(:xpath => lPath).lis(20).size
  end
  
  def delay dTime=3
    @generalTools.wait('youwontfindthis',3)
  end
end