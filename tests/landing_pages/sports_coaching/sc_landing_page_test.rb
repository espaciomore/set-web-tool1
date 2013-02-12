class Tests_LandingPages_SportsCoaching_ScLandingPageTest < Lib_Tests_LandingPagesAcceptanceTest

  def getReportPath
    return Config_Paths::LANDING_PAGES_REPORT_FOLDER_PATH + '/sports_coaching/sports_coaching'
  end

  def runTest
    @vertical = 'sports-coaching'
    @testSite = $target_server + '/' + @vertical
    periodicTableXpath = '//*[@id="periodicTable"]/tbody/tr[6]/td[5]/div/div/div[1]/a'
    pageUrl = $target_server + '/sportSCoacHing'

    @sportsCoachingPage = Hash.new
    @sportsCoachingPage['Periodic Table navigation'] = testPeriodicTableNavigation periodicTableXpath
    @sportsCoachingPage['Going directly to url'] = testOpenPageByUrl pageUrl
    @sportsCoachingPage['Breadcrumb item'] = testBreadcrumb
    @sportsCoachingPage['Bing search'] = testBingResults
    @sportsCoachingPage['Wizard'] = testWizardQuestions
    @sportsCoachingPage['Overlay'] = testOverlay
    @sportsCoachingPage['Email validation'] = testEmailValidation
    @sportsCoachingPage['Recommended verticals'] = testRecommendedVerticals
    @sportsCoachingPage['Join Noodle'] = testJoinNoodle
    @sportsCoachingPage.each do|result,value|
      text = "[Sports Coaching Landing Page][floyd-crossing] Test that " + result + " is working"
      update_report(text, value)
    end
    deleteTestingEmail
  end

  def testWizardQuestions
    @browser.goto @testSite
    @generalTools.waitOrCrash('Where are you located?')
    validatedQuestion1 = testZipCityState
    update_report('[Sports Coaching Landing Page] Validating: "Where are you located?"',
                        validatedQuestion1)

    @generalTools.waitOrCrash('What training type interests you?')
    validatedQuestion2 = testWhatTraining
    update_report('[Sports Coaching Landing Page] Validating: "What training type interests you?"',
                        validatedQuestion2)

    @generalTools.waitOrCrash("What's your skill level?")
    validatedQuestion3 = testSkillLevel
    update_report('[Sports Coaching Landing Page] Validating: "' + "What's your skill level?" + '"',
                        validatedQuestion3)

    doneMessage = @generalTools.waitOrCrash('Here are some sports coaching resources you might be interested in.')
    update_report('[Sports Coaching Landing Page] Wizard done message is appearing',
                        doneMessage)

    if(doneMessage)
      validatedStartOver = testStartOver('Where are you located?')
    else
      validatedStartOver = false
    end
    return validatedQuestion1 && validatedQuestion2 && validatedQuestion3 && doneMessage && validatedStartOver
  end

  def testWhatTraining
    @generalTools.waitOrCrash('//*[@id="questionsStep2"]',0,true)
    xpath = '//*[@id="question2Dropdown"]/select'
    options = @browser.select_list(:xpath, xpath).elements
    @browser.select_list(:xpath, xpath).select options[3].text
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    sleep 1
    return true
  end

  def testSkillLevel
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    validated = @generalTools.wait('Please select a skill level.')
    @generalTools.waitOrCrash('//*[@id="intermediateRadioOption"]',0,true)
    @browser.radio(:id,'intermediateRadioOption').set
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    return validated
  end

  def testRecommendedVerticals
    @browser.goto @testSite
    k8Xpath = '//*[@id="sidebar-right"]/div[1]/div/p[1]/a'
    highSchoolXpath = '//*[@id="sidebar-right"]/div[1]/div/p[2]/a'
    collegeXpath = '//*[@id="sidebar-right"]/div[1]/div/p[3]/a'
    @generalTools.waitOrCrash(k8Xpath,0,true)
    @browser.link(:xpath,k8Xpath).click
    k8 = @generalTools.waitUrl($target_server + '/k-12')

    @browser.goto @testSite
    @generalTools.waitOrCrash(highSchoolXpath,0,true)
    @browser.link(:xpath,highSchoolXpath).click
    highSchool = @generalTools.waitUrl($target_server + '/k-12')

    @browser.goto @testSite
    @generalTools.waitOrCrash(collegeXpath,0,true)
    @browser.link(:xpath,collegeXpath).click
    college = @generalTools.waitUrl($target_server + '/find/college')
    return k8 && highSchool && college
  end
end