class Lib_Tests_HomepageAcceptanceTest < Lib_Tests_AcceptanceTest
  def beforeSetUp
    super
  end
  
  def testWelcomeOverlay
    begin
      @watir_helper.find(:id => 'welcomePageOverlayContainer')
      overlayIsOpened = @watir_helper.style?('display: block;')
      update_report("[Noodle Homepage][alexs-story] Test that user can see a welcome message when user lands on the homepage so user can better understand the product",
                    overlayIsOpened)
    rescue
      #the overlay has random appearence
    end
  end

  def testModule0
    if @generalTools.wait("Find the <span>best match </span>for your education & learning",5)
      update_report('[Noodle Homepage] Test that the Search Bar\'s Background Image is loading', testBGImage('//*[@id="searchBar"]'))
      begin
        search_field = @browser.text_field(:xpath, '//*[@id="keyword"]') 
        searchFieldTest = search_field.focused?
      rescue
        searchFieldTest = false
      end
      if searchFieldTest
        begin
          search_field.set ''
          university = 'Duke'
          search_field.set(university)                
          @generalTools.waitOrCrash('Durham, NC  27708',2)
          @browser.a(:xpath, '//*[@id="headerSearchResults"]/ul/li[2]/a').click()
          searchTest = @generalTools.waitUrl("#{$target_server}/college/duke-university?search=Duke#overview")
        rescue
          searchTest = false
        end         
        update_report("[#{testName}] Test that when user types '#{university}' and clicks that school on the autocomplete, it redirects to the correct school profile",
                            searchTest) 
      end 
    end
  end
    
  def testModule1
      if not @generalTools.wait("What are you looking for?",5)     
        update_report('[Noodle Homepage] Test that the Search Bar\'s Background Image is loading', testBGImage('//*[@id="searchBar"]'))
      end
      begin
        search_field = @browser.text_field(:xpath, '//*[@id="keyword"]') 
        searchFieldTest = search_field.focused?
      rescue
        searchFieldTest = false
      end
      update_report('['+testName+'] Test that cursor initially loads on the search bar', searchFieldTest) 
      if searchFieldTest
        begin     
          search_field.set ''
          university = 'Duke'
          search_field.set(university)                
          @generalTools.waitOrCrash('Durham, NC  27708')
          @browser.a(:xpath, '//*[@id="headerSearchResults"]/ul/li[2]/a').click()
          searchTest = @generalTools.waitUrl("#{$target_server}/college/duke-university?search=Duke#overview")
        rescue
          searchTest = false
        end         
        update_report("[#{testName}] Test that when user types '#{university}' and clicks that school on the autocomplete, it redirects to the correct school profile",
                            searchTest)  
        begin
          @browser.goto testSite 
          @browser.a(:xpath, '//*[@id="magnetfyingButton"]').click()
          doesNothingTest = @generalTools.waitOrCrash("Education search just got smart")
        rescue
          doesNothingTest = false
        end
        update_report('['+testName+'] Test that when user clicks the search button without any selection, it does nothing', 
                            doesNothingTest)       
        begin  
          @browser.text_field(:xpath, '//*[@id="keyword"]').set(university)                
          @browser.a(:xpath, '//*[@id="magnetfyingButton"]').click()
          generalSearchRedirect = @generalTools.waitOrCrash("All results for ")
        rescue
          generalSearchRedirect = false
        end 
        update_report('['+testName+'] Test that when user clicks the search button with some text, it redirects to general search results', 
                            generalSearchRedirect)  
      end   
  end
  
  def testModule2
    begin
      @watir_helper.abutton(:id => 'addVertical').click
      sleep 1
      @watir_helper.find(:id => 'verticalOverlayContainer') 
      guestSearch = @watir_helper.style?('display: block;') 
    rescue
      guestSearch = false
    end  
    update_report('['+testName+'][571] Test that user is getting the "Try a Guest Search" button to load the periodic table overlay like on the dashboard', 
                        guestSearch)   
    begin 
      hasFB = @watir_helper.find(:xpath => '//*[@id="homePageRegisterButton"]').exists?   
      hasFB = (hasFB and login({:using => :facebook, :on => :abstractHeader}))
      logout     
    rescue
      hasFB = false
    end
    update_report('['+testName+'][571] Test that user is getting the "Register with facebook" button to lunch normal Gigya facebook login/sign-up process', 
                        hasFB)  
  end
  
  def testRightRail
      begin
        @browser.goto testSite
        @browser.image(:xpath, '//*[@id="VideoThumbnail"]/img').click()
        videoOverlayTest = @browser.element(:xpath, '//*[@id="homePageVideoContainer"]/div').exists?
      rescue
        videoOverlayTest = false
      end

      update_report('[Noodle Homepage] Test that when user clicks on the video thumbnail image, it loads an overlay',
                          videoOverlayTest)
      if videoOverlayTest
        begin 
          @browser.element(:xpath, '//*[@id="homepage"]/div[6]').click()
          closeOverlayTest = @browser.element(:xpath, '//*[@id="homePageVideoContainer"]/div').exists?      
        rescue
          closeOverlayTest = false
        end
        update_report('[Noodle Homepage] Test that when user clicks outside the overlay, it closes', 
                            closeOverlayTest)
      end

    update_report('[Noodle Homepage][tenaha] Test that the press module is present',
                          @browser.element(:xpath => '//*[@id="pressModule"]').exists?)
  end
end