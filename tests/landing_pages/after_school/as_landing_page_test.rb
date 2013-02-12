class Tests_LandingPages_AfterSchool_AsLandingPageTest < Lib_Tests_LandingPagesAcceptanceTest

  def getReportPath
    return Config_Paths::LANDING_PAGES_REPORT_FOLDER_PATH + '/after_school/after_school'
  end

  def runTest
    @vertical = 'after-school'
    @testSite = $target_server + '/' + @vertical
    periodicTableXpath = '//*[@id="periodicTable"]/tbody/tr[6]/td[2]/div/div/div[1]/a'
    pageUrl = $target_server + '/AfTeRSchool'

    @afterSchoolPage = Hash.new
    @afterSchoolPage['Periodic Table navigation'] = testPeriodicTableNavigation periodicTableXpath
    @afterSchoolPage['Going directly to url'] = testOpenPageByUrl pageUrl
    @afterSchoolPage['Breadcrumb item'] = testBreadcrumb
    @afterSchoolPage['Bing search'] = testBingResults
    @afterSchoolPage['Wizard'] = testWizardQuestions
    @afterSchoolPage['Overlay'] = testOverlay
    @afterSchoolPage['Email validation'] = testEmailValidation
    @afterSchoolPage['Recommended verticals'] = testRecommendedVerticals
    @afterSchoolPage['Join Noodle'] = testJoinNoodle
    @afterSchoolPage.each do|result,value|
      text = "[After School Landing Page][plainfield] Test that " + result + " is working"
      update_report(text, value)
    end
    deleteTestingEmail
  end

  def testWizardQuestions
    @browser.goto @testSite
    @generalTools.waitOrCrash('Where would you like to find after school programs?')
    validatedQuestion1 = testZipCityState
    update_report('[After School Landing Page] Validating: "Where would you like to find after school programs?"',
                        validatedQuestion1)

    @generalTools.waitOrCrash('What grade level are you looking for?')
    validatedQuestion2 = testWhatGrade
    update_report('[After School Landing Page] Validating: "What grade level are you looking for?"',
                        validatedQuestion2)

    @generalTools.waitOrCrash('What type of program are you looking for?')
    validatedQuestion3 = testProgramType
    update_report('[After School Landing Page] Validating: "What type of program are you looking for?"',
                        validatedQuestion3)

    doneMessage = @generalTools.waitOrCrash('Here are some after school programs you might be interested in.')
    update_report('[After School Landing Page] Wizard done message is appearing',
                        doneMessage)

    if(doneMessage)
      validatedStartOver = testStartOver('Where would you like to find after school programs?')
    else
      validatedStartOver = false
    end
    return validatedQuestion1 && validatedQuestion2 && validatedQuestion3 && doneMessage && validatedStartOver
  end

  def testWhatGrade
    @generalTools.waitOrCrash('//*[@id="questionsStep2"]',0,true)
    xpath = '//*[@id="question2Dropdown"]/select'
    options = @browser.select_list(:xpath, xpath).elements
    @browser.select_list(:xpath, xpath).select options[2].text
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    sleep 1
    return true
  end

  def testProgramType
    @generalTools.waitOrCrash('//*[@id="questionsStep3"]',0,true)
    xpath = '//*[@id="question3Dropdown"]/select'
    options = @browser.select_list(:xpath, xpath).elements
    @browser.select_list(:xpath, xpath).select options[3].text
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    sleep 1
    return true
  end

  def testRecommendedVerticals
    @browser.goto @testSite
    k8Xpath = '//*[@id="sidebar-right"]/div[1]/div/p[1]/a'
    tutoringXpath = '//*[@id="sidebar-right"]/div[1]/div/p[2]/a'
    testPrepXpath = '//*[@id="sidebar-right"]/div[1]/div/p[3]/a'
    @generalTools.waitOrCrash(k8Xpath,0,true)
    @browser.link(:xpath,k8Xpath).click
    k8 = @generalTools.waitUrl($target_server + '/k-12')

    @browser.goto @testSite
    @generalTools.waitOrCrash(tutoringXpath,0,true)
    @browser.link(:xpath,tutoringXpath).click
    tutoring = @generalTools.waitUrl($target_server + '/find/tutoring')

    @browser.goto @testSite
    @generalTools.waitOrCrash(testPrepXpath,0,true)
    @browser.link(:xpath,testPrepXpath).click
    testPrep = @generalTools.waitUrl($target_server + '/find/test-prep')

    return k8 && tutoring && testPrep
  end
end