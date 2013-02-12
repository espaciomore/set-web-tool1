class Tests_LandingPages_ReligiousEducation_ReLandingPageTest < Lib_Tests_LandingPagesAcceptanceTest

  def getReportPath
    return Config_Paths::LANDING_PAGES_REPORT_FOLDER_PATH + '/religious_education/religious_education'
  end

  def runTest
    @vertical = 'religious-education'
    @testSite = $target_server + '/' + @vertical
    periodicTableXpath = '//*[@id="periodicTable"]/tbody/tr[5]/td[1]/div/div/div[1]/a'
    pageUrl = $target_server + '/RelIgioUsEducation'

    @religiousEducationPage = Hash.new
    @religiousEducationPage['Periodic Table navigation'] = testPeriodicTableNavigation periodicTableXpath
    @religiousEducationPage['Going directly to url'] = testOpenPageByUrl pageUrl
    @religiousEducationPage['Breadcrumb item'] = testBreadcrumb
    @religiousEducationPage['Bing search'] = testBingResults
    @religiousEducationPage['Wizard'] = testWizardQuestions
    @religiousEducationPage['Overlay'] = testOverlay
    @religiousEducationPage['Email validation'] = testEmailValidation
    @religiousEducationPage['Recommended verticals'] = testRecommendedVerticals
    @religiousEducationPage['Join Noodle'] = testJoinNoodle
    @religiousEducationPage.each do|result,value|
      text = "[Religious Education Landing Page][ponemah] Test that " + result + " is working"
      update_report(text, value)
    end
    deleteTestingEmail
  end

  def testWizardQuestions
    @browser.goto @testSite
    @generalTools.waitOrCrash('Where are you looking to find religious education?')
    validatedQuestion1 = testZipCityState
    update_report('[Religious Education Landing Page] Validating: "Where are you looking to find religious education?"',
                        validatedQuestion1)

    @generalTools.waitOrCrash('What religion are you interested in?')
    validatedQuestion2 = testWhatReligion
    update_report('[Religious Education Landing Page] Validating: "What religion are you interested in?"',
                        validatedQuestion2)

    @generalTools.waitOrCrash('What type of religious education are you looking for?')
    validatedQuestion3 = testEducationType
    update_report('[Religious Education Landing Page] Validating: "What type of religious education are you looking for?"',
                        validatedQuestion3)

    doneMessage = @generalTools.waitOrCrash('Here are some religious education resources you might be interested in.')
    update_report('[Religious Education Landing Page] Wizard done message is appearing',
                        doneMessage)

    if(doneMessage)
      validatedStartOver = testStartOver('Where are you looking to find religious education?')
    else
      validatedStartOver = false
    end
    return validatedQuestion1 && validatedQuestion2 && validatedQuestion3 && doneMessage && validatedStartOver
  end

  def testWhatReligion
    @generalTools.waitOrCrash('//*[@id="questionsStep2"]',0,true)
    xpath = '//*[@id="question2Dropdown"]/select'
    options = @browser.select_list(:xpath, xpath).elements
    @browser.select_list(:xpath, xpath).select options[0].text
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    validated = @generalTools.wait('Please select a religion.')
    @browser.select_list(:xpath, xpath).select options[2].text
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    sleep 1
    return validated
  end

  def testEducationType
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    validated = @generalTools.wait('Please select a type of education.')
    @generalTools.waitOrCrash('//*[@id="classesRadioOption"]',0,true)
    @browser.radio(:id,'classesRadioOption').set
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    return validated
  end

  def testRecommendedVerticals
    @browser.goto @testSite
    k8Xpath = '//*[@id="sidebar-right"]/div[1]/div/p[1]/a'
    highSchoolXpath = '//*[@id="sidebar-right"]/div[1]/div/p[2]/a'
    tutoringXpath = '//*[@id="sidebar-right"]/div[1]/div/p[3]/a'
    @generalTools.waitOrCrash(k8Xpath,0,true)
    @browser.link(:xpath,k8Xpath).click
    k8 = @generalTools.waitUrl($target_server + '/k-12')

    @browser.goto @testSite
    @generalTools.waitOrCrash(highSchoolXpath,0,true)
    @browser.link(:xpath,highSchoolXpath).click
    highSchool = @generalTools.waitUrl($target_server + '/k-12')

    @browser.goto @testSite
    @generalTools.waitOrCrash(tutoringXpath,0,true)
    @browser.link(:xpath,tutoringXpath).click
    tutoring = @generalTools.waitUrl($target_server + '/find/tutoring')

    return k8 && highSchool && tutoring
  end
end