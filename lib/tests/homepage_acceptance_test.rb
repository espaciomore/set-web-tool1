class Lib_Tests_HomepageAcceptanceTest < Lib_Tests_AcceptanceTest
  def beforeSetUp
    super
  end

  def testHeaderContainer
    begin
      fbButton = @watir_helper.find(:xpath => '//*[@id="homePageRegisterButton"]').exists?
    rescue
      fbButton = false
    end
    update_report('[Noodle Homepage] Test that the user can see a Facebook button for signing in or registering', 
                        fbButton)
    begin
      module1 = @watir_helper.img(:xpath => '//*[@id="welcomeHomePageHeader"]/img[1]').loaded?
      module2 = @watir_helper.img(:xpath => '//*[@id="welcomeHomePageHeader"]/img[2]').loaded?
      _bgImages = (module1 && module2)            
    rescue
      _bgImages = false
    end                    
    update_report('[Noodle Homepage] Test that user can see that the background images are loaded', 
                        _bgImages)
  end

  def testPressModule
    begin
      pressModule = @watir_helper.find(:xpath => '//*[@id="homepagePressModule"]').exists?
    rescue
      pressModule = false
    end
    update_report('[Noodle Homepage] Test that the user can see that the Press module is present',
                        pressModule)
  end

  def testCenterModules
    begin
      centerModules = @watir_helper.find(:xpath => '//*[@id="centerModules"]').exists?
    rescue
      centerModules = false
    end
    update_report('[Noodle Homepage] Test that the user can see that the Center modules are present', 
                        centerModules)
    begin
      module1 = @watir_helper.img(:xpath => '//*[@id="homepageImage1"]').loaded?
      module2 = @watir_helper.img(:xpath => '//*[@id="homepageImage2"]').loaded?
      module3 = @watir_helper.img(:xpath => '//*[@id="homepageImage3"]').loaded?
      modulesPresent = (module1 && module2 && module3)
    rescue
      modulesPresent = false
    end
    update_report('[Noodle Homepage] Test that the user actually see that the Center modules are loaded', 
                        modulesPresent)
  end

end