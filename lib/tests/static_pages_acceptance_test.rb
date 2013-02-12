class Lib_Tests_StaticPagesAcceptanceTest < Lib_Tests_AcceptanceTest
  def testLoggedIn
    return false
  end
  
  def beforeSetUp
    super
  end
  
  def testHeader testSite
    begin
      @browser.a(:xpath, '//*[@id="headerBox"]/a').click
      logo = @generalTools.waitUrls(["#{$target_server}/", "#{$target_server}/welcome", "#{$target_server}/home"])
    rescue      
      logo = false
    end
    update_report("[Noodle-Pros][white-oak-west] Test that when user clicks the noodle logo, it redirects to noodle homepage", logo)
    @browser.goto testSite
    begin
      girl = @browser.image(:xpath, '//*[@id="girlBox"]/img').loaded?
    rescue      
      girl = false
    end
    update_report("[Noodle-Pros][white-oak-west] Test that the background image is loading", girl)
  end
end