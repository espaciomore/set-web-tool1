class Lib_Tools_EntityProfileFactory < Lib_Tools_EntityProfile
  def titleTest title
    begin
      result = @watir_helper.reset.h1(:xpath => '//*[@id="profileHeader"]/div[2]/div/div[1]/h1').text.include?(title)
    rescue
      result = false
    end
    update_report('[Entity Profiles]['+entityName+'] Test that the profile title reads as '+title, result)
  end
  
  def overallTest
    # Test profile main page loads
    result = @generalTools.verifyText(['<div id="abstractHeader">',
                                       '<div class="pathBreadcrumbContainer">',
                                       '<div class="profileHeaderContainer">',
                                       '<div id="contentWrapper">',
                                       '<div id="noodleFooter">'])
    update_report('[Entity Profiles]['+entityName+'] Test that '+testSite+' is loading', result)
  end
  
  def rightRailTest list=['Most Recent Noodlings'] 
    # Test right rail
    result = @generalTools.verifyText(list)
    update_report('[Entity Profiles]['+entityName+'] Test that the Right Rail is loading with at least "Most Recent Noodlings"', result)
  end
  
  def linkedInModuleTest matchingSchool
    begin
      profileTitle = matchingSchool
      _iframe = @browser.frame(:xpath => '//*[@id="sidebar-right"]/div/div[1]/div/span/iframe')
      linkedInModule = _iframe.exists?
      begin
        linkedInTitle = _iframe.h1(:xpath => '//*[@id="school-title"]').text
        mapping = @generalTools.including?(profileTitle, linkedInTitle.split(' '))
      rescue
        mapping = false
      end
    rescue
      linkedInModule = false
      mapping = false
    end
    update_report('[Entity Profiles]['+entityName+'] Test that the Right Rail is loading with the LinkedIn plugin as the topmost module', 
                        linkedInModule)
    update_report('[Entity Profiles]['+entityName+'] Test that the Right Rail is loading with the LinkedIn plugin and the correct mapping for the profiles', 
                        mapping)
  end
    
  def tabsTest (tabs=[])
    if tabs.empty?
      tabs = tabsToTest
    end
    tabs.each do |test_tab|
      begin 
        tmp = tabs.dup
        tmp.delete(test_tab)
        tmp.each do |other_tab|
          other_tab += '" style="display: none' 
        end
        @generalTools.clickTab(test_tab)
        result = @generalTools.verifyText(tmp)
      rescue
        result = false
      end
      update_report('[Entity Profiles]['+entityName+'] Test that '+ (test_tab.capitalize) +' tab is working correctly', result)
    end
  end
  
  def profileImageTest
    begin
      result = @watir_helper.reset.img(:xpath => "//div[@id='profileHeader']//div[@class='image']/img").loaded?
    rescue
      result = false
    end
    update_report('[Entity Profiles]['+entityName+'] Test that Profile Image is loading', result)
  end

  def profileFitScore
    result = false
    if(@generalTools.wait('//*[@id="dynamicFixContainer"]/div/span',5,true))
      begin
        fitImage =  @watir_helper.reset.find(:xpath => '//*[@id="dynamicFixContainer"]/div/span').css('background-image')
        fitImage = fitImage.gsub(/url[(]\"|\"[)]$/,"")
        newBrowser = Watir::Browser.new $target_browser
        newBrowser.goto(fitImage)
        result = newBrowser.image(:xpath, "//body/img").loaded?
        newBrowser.close
      rescue
        result = false
      end
    end    
    update_report('[Entity Profiles]['+entityName+'] Test that the Fit Score image is loading', result)
  end
  
  def socialNetworkTest target
    update_report('[Entity Profiles]['+entityName+'][talpa] Test that user gets friends opinions from this profile by clicking on the "askAFriend" button for social networks',
                        @generalTools.testSocialNetwork(target))    
  end
end