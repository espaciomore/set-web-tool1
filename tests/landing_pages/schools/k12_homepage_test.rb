class Tests_LandingPages_Schools_K12HomepageTest < Lib_Tests_HomepageAcceptanceTest
  def getReportPath
    return Config_Paths::HOME_PAGE_REPORT_FOLDER_PATH + '/k12_landing_page'
  end

  def testLoggedIn
    return false
  end
  
  def runTest
    testSite = $target_server + '/k-12'
    @browser.goto testSite
    
    @generalTools.waitOrCrash("Find the right Kindergarten through High School")
    update_report('[K-12 Homepage][powerville] Test that "'+testSite+'" redirects to the k-12 homepage', true)
    
    search_field = @browser.text_field(:xpath, '//*[@id="location"]')  
    search_field.set '331'
    @browser.div(:xpath, '//*[@id="headerContent"]/div[2]').click()
    update_report('[K-12 Homepage][parnell] Validate that the location field defaults to text "Enter city and state or ZIP" for invalid inputs', search_field.value=='Enter city and state or ZIP')
    
    search_field = @browser.text_field(:xpath, '//*[@id="location"]') 
    update_report('[K-12 Homepage][parnell] Validate that the location field is clearing out after clicked, for text "Enter city and state or ZIP"', search_field.value=='Enter city and state or ZIP')
        
    search_field = @browser.text_field(:xpath, '//*[@id="searchForSpecificSchool"]/input')  
    search_field.set 'Yalesville'    
    @generalTools.waitOrCrash("Yalesville")
    @browser.a(:xpath, '//*[@id="verticalLandingPageSearchResults"]/ul/li[1]/a').click()    
    @generalTools.waitOrCrash("Yalesville School")
    update_report('[K-12 Homepage][powerville] Test that when user clicks a school from the autocomplete, it redirects to correct school profile', true) 

    @browser.goto testSite 
    @browser.text_field(:xpath, '//*[@id="searchForSpecificSchool"]/input').set 'Duke'
    @browser.a(:id, 'searchForSpecificSchoolButton').click()
    @generalTools.waitOrCrash("All results for ")
    update_report('[K-12 Homepage][powerville] Test that when user clicks the search button without any selection, it redirects to general search results', true)  
    
    @browser.goto testSite 
    update_report('[K-12 Homepage][parnell] Validating location and grade for get results button',
                        testValidation) 
    
    update_report('[K-12 Homepage][powerville] Test that when user finishes filling out the form and submit it, it redirects to the k-12 wizards results',                                         
                        testWizardPage)        

    update_report("[K-12 Homepage][bethesda] Test that when user is on the k-12 wizard page and user goes back to k-12 homepage, questions still answered",
                        testBackFromWizard)
  end
  
  private
  def testValidation
    begin
      @watir_helper.select_list(:xpath => '//*[@id="grade"]').select 'High School (Grades 9-12)'
      @watir_helper.text_field(:xpath => '//*[@id="location"]').typeBySet 'invalid'
      sleep 1
      @browser.a(:class => 'mButton getResults').click
      canValidate = @watir_helper.find(:xpath => '//*[@id="qtip-0"]').attr(:class).include?('qtip-active')
    rescue
      canValidate = false
    end    
    return canValidate
  end  
  
  def testWizardPage
    begin
      @watir_helper.select_list(:xpath => '//*[@id="grade"]').select 'High School (Grades 9-12)'
      @watir_helper.text_field(:xpath => '//*[@id="location"]').typeBySet '07901'
      sleep 1
      @browser.a(:class => 'mButton getResults').click 
      correct = @generalTools.wait("Are you looking for any of these school characteristics?",5)
    rescue
      correct = false
    end
    return correct  
  end
  
  def testBackFromWizard
    begin
      @browser.a(:xpath => '//*[@id="pathBreadcrumb"]/div[2]/div[1]/a').click 
      search_field = @browser.text_field(:xpath, '//*[@id="location"]')
      notEmpty = (search_field.value=='07901')
    rescue
      notEmpty = false
    end
    return notEmpty
  end
end