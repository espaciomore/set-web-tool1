class Tests_LandingPages_Technology_TeLandingPageTest < Lib_Tests_LandingPagesAcceptanceTest

  def getReportPath
    return Config_Paths::LANDING_PAGES_REPORT_FOLDER_PATH + '/technology/technology'
  end

  def runTest
    @vertical = 'technology'
    @testSite = $target_server + '/' + @vertical
    periodicTableXpath = '//*[@id="periodicTable"]/tbody/tr[3]/td[8]/div/div/div[1]/a'
    pageUrl = $target_server + '/technology'

    @technologyPage = Hash.new
    @technologyPage['Periodic Table navigation'] = testPeriodicTableNavigation periodicTableXpath
    @technologyPage['Going directly to url'] = testOpenPageByUrl pageUrl
    @technologyPage['Breadcrumb item'] = testBreadcrumb
    @technologyPage['Bing search'] = testBingResults
    @technologyPage['Wizard'] = testWizardQuestions
    @technologyPage['Overlay'] = testOverlay
    @technologyPage['Email validation'] = testEmailValidation
    @technologyPage['Recommended verticals'] = testRecommendedVerticals
    @technologyPage['Join Noodle'] = testJoinNoodle
    @technologyPage.each do|result,value|
      text = "[Technology Landing Page][south-vinemont] Test that " + result + " is working"
      update_report(text, value)
    end
    deleteTestingEmail
  end

  def testWizardQuestions
    @browser.goto @testSite
    @generalTools.waitOrCrash('Where are you located?')
    validatedQuestion1 = testZipCityState
    update_report('[Technology Landing Page] Validating: "Where are you located?"',
                        validatedQuestion1)

    @generalTools.waitOrCrash('What field of technology are you interested in?')
    validatedQuestion2 = testTechField
    update_report('[Technology Landing Page] Validating: "What kind of music lessons interest you?"',
                        validatedQuestion2)

    @generalTools.waitOrCrash("What type of learning are you looking for?")
    validatedQuestion3 = testLearningType
    update_report('[Technology Landing Page] Validating: "' + "What type of learning are you looking for?" + '"',
                        validatedQuestion3)

    doneMessage = @generalTools.waitOrCrash('Here are some technology resources you might be interested in.')
    update_report('[Technology Landing Page] Wizard done message is appearing',
                        doneMessage)

    if(doneMessage)
      validatedStartOver = testStartOver('Where are you located?')
    else
      validatedStartOver = false
    end
    return validatedQuestion1 && validatedQuestion2 && validatedQuestion3 && doneMessage && validatedStartOver
  end

  def testTechField
    @generalTools.waitOrCrash('//*[@id="questionsStep2"]',0,true)
    xpath = '//*[@id="question2Dropdown"]/select'
    options = @browser.select_list(:xpath, xpath).elements
    @browser.select_list(:xpath, xpath).select options[0].text
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    validated = @generalTools.wait('Please select a field of interest')
    @browser.select_list(:xpath, xpath).select options[2].text
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    sleep 1
    return validated
  end

  def testLearningType
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    validated = @generalTools.wait('Please select a learning type')
    @generalTools.waitOrCrash('//*[@id="programRadioOption"]',0,true)
    @browser.radio(:id,'programRadioOption').set
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    return validated
  end

  def testRecommendedVerticals
    @browser.goto @testSite
    tutoringXpath = '//*[@id="sidebar-right"]/div[1]/div/p[1]/a'
    testPrepXpath = '//*[@id="sidebar-right"]/div[1]/div/p[2]/a'
    collegeXpath = '//*[@id="sidebar-right"]/div[1]/div/p[3]/a'
    @generalTools.waitOrCrash(tutoringXpath,0,true)
    @browser.link(:xpath,tutoringXpath).click
    tutoring = @generalTools.waitUrl($target_server + '/find/tutoring')

    @browser.goto @testSite
    @generalTools.waitOrCrash(testPrepXpath,0,true)
    @browser.link(:xpath,testPrepXpath).click
    testPrep = @generalTools.waitUrl($target_server + '/find/test-prep')

    @browser.goto @testSite
    @generalTools.waitOrCrash(collegeXpath,0,true)
    @browser.link(:xpath,collegeXpath).click
    college = @generalTools.waitUrl($target_server + '/find/college')

    return tutoring && testPrep && college
  end
end