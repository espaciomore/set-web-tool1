class Lib_Tests_LandingPagesAcceptanceTest < Lib_Tests_AcceptanceTest

  def testLoggedIn
    return false
  end
  
  def testPeriodicTableNavigation(periodicTableXpath,fromLeft=true)
    @browser.goto $target_server

   if(!@browser.div(:xpath,"#{periodicTableXpath}").exists?)
   return true
   end

    if(@browser.div(:id,'welcomePageOverlayContainer').exists?)
      if(@browser.div(:id,'welcomePageOverlayContainer').visible?)
        @browser.link(:xpath,'//*[@id="welcomePageOverlayContainer"]//p[@class="closeContainer"]/a').click
        sleep 3
      end
    end

    itemShows = @generalTools.wait(periodicTableXpath,0,true)
    if(itemShows)
      if(fromLeft)
        @browser.span(:xpath,'//*[@id="periodicTable"]/tbody/tr[3]/td[4]/div/div[1]/span').click
      end
      @browser.a(:xpath,periodicTableXpath).click
    end
    landingPage = @generalTools.waitUrl(@testSite)
    @browser.goto $target_server
    return itemShows && landingPage
  end

  def testOpenPageByUrl(pageUrl)
    @generalTools.waitUrl($target_server+'/')
    @browser.goto pageUrl
    redirected = @generalTools.waitUrl(@testSite)
    return redirected
  end

  def testBreadcrumb
    @browser.goto @testSite
    itemShows = @generalTools.wait('//*[@id="pathBreadcrumb"]/div[2]/div[1]/a/span',0,true)
    if(itemShows)
      @browser.span(:xpath,'//*[@id="pathBreadcrumb"]/div[2]/div[1]/a/span').click
    end
    homePageLoaded = @generalTools.waitUrl($target_server+'/')
    return itemShows && homePageLoaded
  end

  def testBingResults
    @browser.goto @testSite
    itemShows = @generalTools.wait('//*[@id="bingResults"]/ul/li[1]',0,true)
    if(itemShows)
      @browser.a(:xpath,'//*[@id="bingResults"]/ul/li[1]/h3/a').click
    end
    tabOpened = @browser.window(:index => 1).exists?
    if(tabOpened)
      @browser.window(:index => 1).close
    end
    return tabOpened && itemShows
  end

  def testOverlay
    deleteTestingEmail
    @browser.goto @testSite
    @generalTools.waitOrCrash('//*[@id="genericInactiveEmailInputField"]',0,true)
    @browser.text_field(:id,'genericInactiveEmailInputField').set 'test@test.com'
    @browser.span(:xpath,'//*[@id="genericInactiveEmailButton"]/span/span/span').click
    overlayShows = @generalTools.verifyText("Thanks for signing up. We'll be in touch!")
    if(overlayShows)
      @browser.span(:xpath,'//*[@id="genericInactiveLandingPageConfirmationOverlayContainer"]/div/div/p/a/span/span/span').click
    end
    return overlayShows
  end

  def testEmailValidation
    @browser.goto @testSite
    @generalTools.waitOrCrash('//*[@id="genericInactiveEmailInputField"]',0,true)
    @browser.text_field(:id,'genericInactiveEmailInputField').set '123@noodle'
    @browser.span(:xpath,'//*[@id="genericInactiveEmailButton"]/span/span/span').click
    sleep 3
    begin
      emailValidated = @browser.div(:xpath,'//*[@id="qtip-0"]').visible?
    rescue
      emailValidated = false
    end
    @browser.text_field(:id,'genericInactiveEmailInputField').set 'test@test.com'
    @browser.span(:xpath,'//*[@id="genericInactiveEmailButton"]/span/span/span').click
    sleep 3
    emailExists = @browser.div(:xpath,'//*[@id="qtip-1"]').visible?
    return emailValidated && emailExists
  end

  def testJoinNoodle
    @browser.goto @testSite
    @generalTools.waitOrCrash('//*[@id="sidebar-right"]/div[3]/div/a',0,true)
    @browser.link(:xpath,'//*[@id="sidebar-right"]/div[3]/div/a').click
    sleep 2
    registerShowed = @browser.div(:xpath,'//*[@id="signUpOverlayContainer"]').visible?
    login({:using => :test_user, :on => :abstractHeader})
    sleep 2
    @browser.goto @testSite
    joinIsNotShowed = !@generalTools.wait('//*[@id="sidebar-right"]//*[@class="loginOverlayActivator"]',5,true)
    return registerShowed && joinIsNotShowed
  end

  def deleteTestingEmail
    @browser.goto @testSite + '?eraseEmail=true'
  end

  def testZipCityState
    @generalTools.waitOrCrash('//*[@id="questionsLocationInput"]',0,true)
    @browser.text_field(:id,'questionsLocationInput').set '1234'
    @browser.span(:xpath,'//*[@id="questionsStep1"]/span/span/span').click
    sleep 3
    begin
      zipValidated = @browser.div(:xpath,'//*[@id="qtip-2"]').visible?
    rescue
      zipValidated = false
    end

    @browser.text_field(:id,'questionsLocationInput').set 'asdf'
    @browser.span(:xpath,'//*[@id="questionsStep1"]/span/span/span').click
    sleep 3
    begin
      cityValidated = @browser.div(:xpath,'//*[@id="qtip-2"]').visible?
    rescue
      cityValidated = false
    end

    @browser.text_field(:id,'questionsLocationInput').set '33180'
    @browser.span(:xpath,'//*[@id="questionsStep1"]/span/span/span').click
    sleep 1
    return zipValidated && cityValidated
  end

  def testStartOver(firstQuestion)
    @generalTools.waitOrCrash('//a[@class="startOver"]',0,true)
    @browser.span(:xpath,'//a[@class="startOver"]/span[2]').click
    sleep 3
    showedFirst = @generalTools.verifyText(firstQuestion)
    return showedFirst
  end
end