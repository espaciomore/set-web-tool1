class Tests_LandingPages_ProfessionalDevelopment_PdLandingPageTest < Lib_Tests_LandingPagesAcceptanceTest

  def getReportPath
    return Config_Paths::LANDING_PAGES_REPORT_FOLDER_PATH + '/professional_development/professional_development'
  end

  def runTest
    @vertical = 'professional-development'
    @testSite = $target_server + '/' + @vertical
    periodicTableXpath = '//*[@id="periodicTable"]/tbody/tr[4]/td[8]/div/div/div[1]/a'
    pageUrl = $target_server + '/professiONalDeVELOpment'

    @professionalDevelopmentPage = Hash.new
    @professionalDevelopmentPage['Periodic Table navigation'] = testPeriodicTableNavigation periodicTableXpath
    @professionalDevelopmentPage['Going directly to url'] = testOpenPageByUrl pageUrl
    @professionalDevelopmentPage['Breadcrumb item'] = testBreadcrumb
    @professionalDevelopmentPage['Bing search'] = testBingResults
    @professionalDevelopmentPage['Wizard'] = testWizardQuestions
    @professionalDevelopmentPage['Overlay'] = testOverlay
    @professionalDevelopmentPage['Email validation'] = testEmailValidation
    @professionalDevelopmentPage['Recommended verticals'] = testRecommendedVerticals
    @professionalDevelopmentPage['Join Noodle'] = testJoinNoodle
    @professionalDevelopmentPage.each do|result,value|
      text = "[Professional Development Landing Page][southwest-ranches] Test that " + result + " is working"
      update_report(text, value)
    end
    deleteTestingEmail
  end

  def testWizardQuestions
    @browser.goto @testSite
    @generalTools.waitOrCrash('Where are you located?')
    validatedQuestion1 = testZipCityState
    update_report('[Professional Development Landing Page] Validating: "Where are you located?"',
                        validatedQuestion1)

    @generalTools.waitOrCrash('What would you like to learn more about?')
    validatedQuestion2 = testWhatLearning
    update_report('[Professional Development Landing Page] Validating: "What would you like to learn more about?"',
                        validatedQuestion2)

    @generalTools.waitOrCrash("How would you like to learn?")
    validatedQuestion3 = testHowLearning
    update_report('[Professional Development Landing Page] Validating: "How would you like to learn?"',
                        validatedQuestion3)

    doneMessage = @generalTools.waitOrCrash('Here are some professional developments resources you might be interested in.')
    update_report('[Professional Development Landing Page] Wizard done message is appearing',
                        doneMessage)

    if(doneMessage)
      validatedStartOver = testStartOver('Where are you located?')
    else
      validatedStartOver = false
    end
    return validatedQuestion1 && validatedQuestion2 && validatedQuestion3 && doneMessage && validatedStartOver
  end

  def testWhatLearning
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

  def testHowLearning
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    validated = @generalTools.wait('Please select a learning type')
    @generalTools.waitOrCrash('//*[@id="programsRadioOption"]',0,true)
    @browser.radio(:id,'programsRadioOption').set
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    return validated
  end

  def testRecommendedVerticals
    @browser.goto @testSite
    tutoringXpath = '//*[@id="sidebar-right"]/div[1]/div/p[1]/a'
    collegeXpath = '//*[@id="sidebar-right"]/div[1]/div/p[2]/a'
    graduateXpath = '//*[@id="sidebar-right"]/div[1]/div/p[3]/a'
    @generalTools.waitOrCrash(tutoringXpath,0,true)
    @browser.link(:xpath,tutoringXpath).click
    tutoring = @generalTools.waitUrl($target_server + '/find/tutoring')

    @browser.goto @testSite
    @generalTools.waitOrCrash(collegeXpath,0,true)
    @browser.link(:xpath,collegeXpath).click
    college = @generalTools.waitUrl($target_server + '/find/college')

    @browser.goto @testSite
    @generalTools.waitOrCrash(graduateXpath,0,true)
    @browser.link(:xpath,graduateXpath).click
    graduate = @generalTools.waitUrl($target_server + '/find/graduate')

    return tutoring && college && graduate
  end
end