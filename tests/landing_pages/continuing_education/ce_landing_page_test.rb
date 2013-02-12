class Tests_LandingPages_ContinuingEducation_CeLandingPageTest < Lib_Tests_LandingPagesAcceptanceTest

  def getReportPath
    return Config_Paths::LANDING_PAGES_REPORT_FOLDER_PATH + '/continuing_education/continuing_education'
  end

  def runTest
    @vertical = 'continuing-education'
    @testSite = $target_server + '/' + @vertical
    periodicTableXpath = '//*[@id="periodicTable"]/tbody/tr[1]/td[8]/div/div/div[1]/a'
    pageUrl = $target_server + '/ConTiNuinGEducation'

    @continuingEducationPage = Hash.new
    @continuingEducationPage['Periodic Table navigation'] = testPeriodicTableNavigation periodicTableXpath
    @continuingEducationPage['Going directly to url'] = testOpenPageByUrl pageUrl
    @continuingEducationPage['Breadcrumb item'] = testBreadcrumb
    @continuingEducationPage['Bing search'] = testBingResults
    @continuingEducationPage['Wizard'] = testWizardQuestions
    @continuingEducationPage['Overlay'] = testOverlay
    @continuingEducationPage['Email validation'] = testEmailValidation
    @continuingEducationPage['Recommended verticals'] = testRecommendedVerticals
    @continuingEducationPage['Join Noodle'] = testJoinNoodle
    @continuingEducationPage.each do|result,value|
      text = "[Continuing Education Landing Page][fort-stockton] Test that " + result + " is working"
      update_report(text, value)
    end
    deleteTestingEmail
  end

  def testWizardQuestions
    @browser.goto @testSite
    @generalTools.waitOrCrash('Where are you located?')
    validatedQuestion1 = testZipCityState
    update_report('[Continuing Education Landing Page] Validating: "Where are you located?"',
                        validatedQuestion1)

    @generalTools.waitOrCrash('What field are you interested in?')
    validatedQuestion2 = testWhatField
    update_report('[Continuing Education Landing Page] Validating: "What field are you interested in?"',
                        validatedQuestion2)

    @generalTools.waitOrCrash('What type of learning are you looking for?')
    validatedQuestion3 = testEducationType
    update_report('[Continuing Education Landing Page] Validating: "What type of learning are you looking for?"',
                        validatedQuestion3)

    doneMessage = @generalTools.waitOrCrash('Here are some continuing education resources you might be interested in.')
    update_report('[Continuing Education Landing Page] Wizard done message is appearing',
                        doneMessage)

    if(doneMessage)
      validatedStartOver = testStartOver('Where are you located?')
    else
      validatedStartOver = false
    end
    return validatedQuestion1 && validatedQuestion2 && validatedQuestion3 && doneMessage && validatedStartOver
  end

  def testWhatField
    @generalTools.waitOrCrash('//*[@id="questionsStep2"]',0,true)
    xpath = '//*[@id="question2Dropdown"]/select'
    options = @browser.select_list(:xpath, xpath).elements
    @browser.select_list(:xpath, xpath).select options[2].text
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    sleep 1
    return true
  end

  def testEducationType
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    validated = @generalTools.wait('Please select an area of learning.')
    @generalTools.waitOrCrash('//*[@id="courseRadioOption"]',0,true)
    @browser.radio(:id,'courseRadioOption').set
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    return validated
  end

  def testRecommendedVerticals
    @browser.goto @testSite
    tutoringXpath = '//*[@id="sidebar-right"]/div[1]/div/p[1]/a'
    graduateXpath = '//*[@id="sidebar-right"]/div[1]/div/p[2]/a'
    mbaXpath = '//*[@id="sidebar-right"]/div[1]/div/p[3]/a'
    @generalTools.waitOrCrash(tutoringXpath,0,true)
    @browser.link(:xpath,tutoringXpath).click
    tutoring = @generalTools.waitUrl($target_server + '/find/tutoring')

    @browser.goto @testSite
    @generalTools.waitOrCrash(graduateXpath,0,true)
    @browser.link(:xpath,graduateXpath).click
    graduate = @generalTools.waitUrl($target_server + '/find/graduate')

    @browser.goto @testSite
    @generalTools.waitOrCrash(mbaXpath,0,true)
    @browser.link(:xpath,mbaXpath).click
    mba = @generalTools.waitUrl($target_server + '/find/mba')

    return mba && graduate && tutoring
  end
end