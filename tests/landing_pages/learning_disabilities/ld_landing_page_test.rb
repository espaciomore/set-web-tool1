class Tests_LandingPages_LearningDisabilities_LdLandingPageTest < Lib_Tests_LandingPagesAcceptanceTest

  def getReportPath
    return Config_Paths::LANDING_PAGES_REPORT_FOLDER_PATH + '/learning_disabilities/learning_disabilities'
  end

  def runTest
    @vertical = 'learning-disabilities'
    @testSite = $target_server + '/' + @vertical
    periodicTableXpath = '//*[@id="periodicTable"]/tbody/tr[5]/td[2]/div/div/div[1]/a'
    pageUrl = $target_server + '/LearNINgDisabiliTies'

    @learningDisabilitiesPage = Hash.new
    @learningDisabilitiesPage['Periodic Table navigation'] = testPeriodicTableNavigation periodicTableXpath
    @learningDisabilitiesPage['Going directly to url'] = testOpenPageByUrl pageUrl
    @learningDisabilitiesPage['Breadcrumb item'] = testBreadcrumb
    @learningDisabilitiesPage['Bing search'] = testBingResults
    @learningDisabilitiesPage['Wizard'] = testWizardQuestions
    @learningDisabilitiesPage['Overlay'] = testOverlay
    @learningDisabilitiesPage['Email validation'] = testEmailValidation
    @learningDisabilitiesPage['Recommended verticals'] = testRecommendedVerticals
    @learningDisabilitiesPage['Join Noodle'] = testJoinNoodle
    @learningDisabilitiesPage.each do|result,value|
      text = "[Learning Disabilities Landing Page][pocatello] Test that " + result + " is working"
      update_report(text, value)
    end
    deleteTestingEmail
  end

  def testWizardQuestions
    @browser.goto @testSite
    @generalTools.waitOrCrash('Where are you located?')
    validatedQuestion1 = testZipCityState
    update_report('[Learning Disabilities Landing Page] Validating: "Where are you located?"',
                        validatedQuestion1)

    @generalTools.waitOrCrash('Which learning disability are you looking for?')
    validatedQuestion2 = testWhatDisability
    update_report('[Learning Disabilities Landing Page] Validating: "Which learning disability are you looking for?"',
                        validatedQuestion2)

    @generalTools.waitOrCrash('What type of resource are you looking for?')
    validatedQuestion3 = testResourceType
    update_report('[Learning Disabilities Landing Page] Validating: "What type of resource are you looking for?"',
                        validatedQuestion3)

    doneMessage = @generalTools.waitOrCrash('Here are some learning disabilities resources you might be interested in.')
    update_report('[Learning Disabilities Landing Page] Wizard done message is appearing',
                        doneMessage)

    if(doneMessage)
      validatedStartOver = testStartOver('Where are you located?')
    else
      validatedStartOver = false
    end
    return validatedQuestion1 && validatedQuestion2 && validatedQuestion3 && doneMessage && validatedStartOver
  end

  def testWhatDisability
    @generalTools.waitOrCrash('//*[@id="questionsStep2"]',0,true)
    xpath = '//*[@id="question2Dropdown"]/select'
    options = @browser.select_list(:xpath, xpath).elements
    @browser.select_list(:xpath, xpath).select options[2].text
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    sleep 1
    return true
  end

  def testResourceType
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    validated = @generalTools.wait('Please select a type of resource.')
    @generalTools.waitOrCrash('//*[@id="communitiesRadioOption"]',0,true)
    @browser.radio(:id,'communitiesRadioOption').set
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    return validated
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