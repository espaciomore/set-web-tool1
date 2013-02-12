class Tests_NeedRegistration_Users_HomeTest < Lib_Tests_UserAcceptanceTest

  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/users/user_home'
  end  

  def testLoggedOut
    return false
  end

  def getFriendlyName
    return "User Home"
  end
      
  def runTest               
    update_report("[Dashboard] Test that user can see that the left rail has been loaded",
                  test_left_rail)
    update_report("[Dashboard] Test that user can see that user's backpack",
                  test_yourbackpack_section)
    update_report("[Dashboard] Test that user can see an invite friends overlay and that it validates",
                  test_invite_yourfriends(getLRSections[2]))
    update_report("[Dashboard] Test that user can recommended category section is present",
                  test_recommended_categories)              
    update_report("[Dashboard] Test that user can see that the center content has been loaded",
                  test_center_content)
    update_report("[Dashboard] Test that user can use the load more button at the bottom, to see more items",
                  test_load_more)          
  end
  
  private 
  
  def test_left_rail
    Proc.new do
      begin
        raise "verify left-rail present" if not onLeftRail.exists?
        _sections = getLRSections
        raise "verify left-rail user-name present" if not _sections[0].span(:class => 'username').text.include?('Noodle test')
        #raise "verify left-rail backpack present" if not _sections[1].h3(:xpath => 'div[1]/h3').text.include?('Your Backpack')
        raise "verify left-rail friends present" if not _sections[2].h3(:xpath => 'div[1]/h3').text.include?('Friends')
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end

  def test_yourbackpack_section
    Proc.new do
      begin
        sitemap = Config_Mappings::VERTICAL_URL
        for i in 2..10
          component = onBackpack.link(:xpath => "div[#{i}]/div[1]/table/tbody/tr/td[2]/a")
          component.click
          vertical = component.text
          sleep 1
          if vertical!= 'Learning Materials'
            raise "verify backpack #{vertical} search present" if !(onBackpack.link(:xpath => "div[#{i}]/ul/li[1]/a").text=="Search")
            raise "verify backpack #{vertical} favorites present" if !(onBackpack.link(:xpath => "div[#{i}]/ul/li[2]/a").text=="Favorites")
          else
            raise "verify backpack #{vertical} search present" if !(onBackpack.link(:xpath => "div[#{i}]/ul/li[1]/a").text=="Search")
          end
          raise "verify backpack #{vertical} link" if not "#{$target_server}/#{sitemap[vertical]}"==onBackpack.link(:xpath => "div[#{i}]/ul/li[1]/a").attribute_value(:href)
        end
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
        _sections = getCenterContent#[2..3]
        #print "\nStart: ",DateTime.now,"\n"
        _index = 0
        _sections.each do |row|
          @watir_helper.setElement(row).ul.lis(4).each do |column|
            if @watir_helper.setElement(column).attribute_value(:class).include?('big')
              raise "verify item#{_index.to_s} title" if not @watir_helper.setElement(column).h3(:xpath => 'div[1]/h3').text!=''
              raise "verify item#{_index.to_s} image" if not @watir_helper.setElement(column).image(:xpath => 'div[2]/img').loaded?
              raise "verify item#{_index.to_s} description 1" if not @watir_helper.setElement(column).p(:xpath => '//p[@class="addDescription"]').text!=''
              raise "verify item#{_index.to_s} description 2" if not @watir_helper.setElement(column).p(:xpath => '//p[@class="addBottomText"]').text==''
              raise "verify item#{_index.to_s} link" if not @watir_helper.setElement(column).a.text!=''
            else
              raise "verify item#{_index.to_s} title" if not @watir_helper.setElement(column).h3(:xpath => 'a/div[1]/div[1]/h3').text!=''
              raise "verify item#{_index.to_s} image" if not @watir_helper.setElement(column).image(:xpath => 'a/div[1]/div[2]/div[1]/img').loaded?
              raise "verify item#{_index.to_s} description 1" if not @watir_helper.setElement(column).h2(:xpath => 'a/div[1]/div[2]/h2').text!=''
              raise "verify item#{_index.to_s} description 2" if not @watir_helper.setElement(column).p(:xpath => '//p[@class="author"]').text!=''
              raise "verify item#{_index.to_s} description 3" if not @watir_helper.setElement(column).p(:xpath => '//p[@class="noodlingBodyText"]').text!=''
            end
            _index += 1
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
  
  def test_recommended_categories
    Proc.new do
      begin
        catList = on_recommended_categories_container.divs(8)
        raise "verify recommended categories title" if not on_recommended_categories_container.h1( :text => 'Get started here:').exists?
        raise "verify category Learning Materials present" if not @watir_helper.setElement(catList[0]).link( :text => /Learning Materials/ ).exists?
        raise "verify category K-12 present" if not @watir_helper.setElement(catList[1]).link( :text => /K-12/ ).exists?
        raise "verify category College present" if not @watir_helper.setElement(catList[2]).link( :text => /College/ ).exists?
        raise "verify category Tutoring present" if not @watir_helper.setElement(catList[3]).link( :text => /Tutoring/ ).exists?
        raise "verify category Test Prep present" if not @watir_helper.setElement(catList[4]).link( :text => /Test Prep/ ).exists?
        raise "verify category Study Abroad present" if not @watir_helper.setElement(catList[5]).link( :text => /Study Abroad/ ).exists?
        raise "verify category Graduate present" if not @watir_helper.setElement(catList[6]).link( :text => /Graduate/ ).exists?
        raise "verify category Guidance Counseling present" if not @watir_helper.setElement(catList[7]).link( :text => /Guidance Counseling/ ).exists?
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end
  
  def onInvite
    @watir_helper.reset
    return @watir_helper.div(:xpath => '//*[@id="betaInviteYourFriendsOverlayContainer"]/div')
  end
  
  def test_invite_yourfriends section
    Proc.new do
      begin
        section.div.a.click
        sleep 2
        @watir_helper.reset.div(:xpath => '//*[@id="betaInviteYourFriendsOverlayContainer"]').waitOnEval("style?('display: block;')")
        raise "verify invite-your-friends title" if not onInvite.h4(:xpath => 'div[1]/div/h4').text.include?("Invite your friends") 
        raise "verify invite-your-friends title" if not onInvite.text_field(:xpath => '//*[@id="friendsMails"]').text.include?("Your friends' email(s)")
        onInvite.find(:text => 'Submit').clickOn
        @watir_helper.reset.div(:id => 'container').click
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end

  def test_load_more
    Proc.new do
      begin
        _sizeBefore = onCenter.ul.lis(80).size
        @watir_helper.reset.link(:xpath => '//*[@id="loadMoreContent"]').click
        sleep 3
        raise "verify new content after loading more" if not onCenter.h1( :text => 'Content curated for you:' ).exists?
        _sizeAfter = onCenter.ul.lis(100).size     
        raise "verify items after loading more" if not _sizeBefore < _sizeAfter
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end
      
  def onBanner(bPath='//div[@class="dashboardWelcomeBannerContainer"]')
    return @watir_helper.reset.div(:xpath => bPath)
  end
  
  def getBannerBadge(bbPath='//div[@class="imageContainer"]')    
    return onBanner.div(:xpath => bbPath).style('background-image').to_s
  end
  
  def getBannerTitle(btPath='h1')
    return onBanner.h1(:xpath => btPath).text
  end
  
  def onLeftRail(lrPath='//*[@id="genericSmallLeftColumn"]')
    return @watir_helper.reset.div(:xpath => lrPath)
  end
  
  def getLRSections
    return onLeftRail.divs(3)
  end
  
  def onCenter(cPath='//*[@id="squeeze"]')
    return @watir_helper.reset.div(:xpath => cPath)
  end
  
  def getCenterContent(ccPath='ul')
    return onCenter.ul.lis(2)
  end
  
  def onBackpack
    @watir_helper.reset.div(:xpath => '//*[@id="navigation"]/div[1]')
  end
  
  def on_recommended_categories_container
    onCenter.div( :class => 'recommendedCategoriesContainer' )
  end
end