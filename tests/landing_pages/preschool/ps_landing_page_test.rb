class Tests_LandingPages_Preschool_PsLandingPageTest < Lib_Tests_LandingPagesAcceptanceTest

  def getReportPath
    return Config_Paths::LANDING_PAGES_REPORT_FOLDER_PATH + '/preschool/preschool'
  end

  def runTest
    @vertical = 'preschool'
    @testSite = $target_server + '/' + @vertical
    periodicTableXpath = '//*[@id="periodicTable"]/tbody/tr[1]/td[1]/div/div/div[1]/a'
    pageUrl = $target_server + '/PRe-school'

    @preschoolPage = Hash.new
    @preschoolPage['Periodic Table navigation'] = testPeriodicTableNavigation periodicTableXpath
    @preschoolPage['Going directly to url'] = testOpenPageByUrl pageUrl
    @preschoolPage['Breadcrumb item'] = testBreadcrumb
    @preschoolPage['Bing search'] = testBingResults
    @preschoolPage['Wizard'] = testWizardQuestions
    @preschoolPage['Overlay'] = testOverlay
    @preschoolPage['Email validation'] = testEmailValidation
    @preschoolPage['Recommended verticals'] = testRecommendedVerticals
    @preschoolPage['Join Noodle'] = testJoinNoodle
    @preschoolPage.each do|result,value|
      text = "[Preschool Landing Page][pink] Test that " + result + " is working"
      update_report(text, value)
    end
    deleteTestingEmail
  end

  def testWizardQuestions
    @browser.goto @testSite
    @generalTools.waitOrCrash('Where do you want to find a preschool?')
    validatedQuestion1 = testZipCityState
    update_report('[Preschool Landing Page] Validating: "Where do you want to find a preschool?"',
                        validatedQuestion1)

    @generalTools.waitOrCrash('Are you interested in a specific teaching method?')
    validatedQuestion2 = testTeachingMethod
    update_report('[Preschool Landing Page] Validating: "Are you interested in a specific teaching method?"',
                        validatedQuestion2)

    @generalTools.waitOrCrash('Are you looking for a full or half day school?')
    validatedQuestion3 = testFullHalfDaySchool
    update_report('[Preschool Landing Page] Validating: "Are you looking for a full or half day school?"',
                        validatedQuestion3)

    doneMessage = @generalTools.waitOrCrash('Here are some preschools you might be interested in.')
    update_report('[Preschool Landing Page] Wizard done message is appearing',
                        doneMessage)

    if(doneMessage)
      validatedStartOver = testStartOver('Where do you want to find a preschool?')
    else
      validatedStartOver = false
    end
    return validatedQuestion1 && validatedQuestion2 && validatedQuestion3 && doneMessage && validatedStartOver
  end

  def testTeachingMethod
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    validated = @generalTools.wait('Please select a teaching method.')
    @generalTools.waitOrCrash('//*[@id="teacherDirectedRadioOption"]',0,true)
    @browser.radio(:id,'teacherDirectedRadioOption').set
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    sleep 1
    return true
  end

  def testFullHalfDaySchool
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    validated = @generalTools.wait('Please select a full or half day.')
    @generalTools.waitOrCrash('//*[@id="fullDayRadioOption"]',0,true)
    @browser.radio(:id,'fullDayRadioOption').set
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