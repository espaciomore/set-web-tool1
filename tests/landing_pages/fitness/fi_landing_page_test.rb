class Tests_LandingPages_Fitness_FiLandingPageTest < Lib_Tests_LandingPagesAcceptanceTest

  def getReportPath
    return Config_Paths::LANDING_PAGES_REPORT_FOLDER_PATH + '/fitness/fitness'
  end

  def runTest
    @vertical = 'fitness'
    @testSite = $target_server + '/' + @vertical
    periodicTableXpath = '//*[@id="periodicTable"]/tbody/tr[6]/td[3]/div/div/div[1]/a'
    pageUrl = $target_server + '/fitness'

    @fitnessPage = Hash.new
    @fitnessPage['Periodic Table navigation'] = testPeriodicTableNavigation periodicTableXpath
    @fitnessPage['Going directly to url'] = testOpenPageByUrl pageUrl
    @fitnessPage['Breadcrumb item'] = testBreadcrumb
    @fitnessPage['Bing search'] = testBingResults
    @fitnessPage['Wizard'] = testWizardQuestions
    @fitnessPage['Overlay'] = testOverlay
    @fitnessPage['Email validation'] = testEmailValidation
    @fitnessPage['Recommended verticals'] = testRecommendedVerticals
    @fitnessPage['Join Noodle'] = testJoinNoodle
    @fitnessPage.each do|result,value|
      text = "[Fitness Landing Page][farmers-branch] Test that " + result + " is working"
      update_report(text, value)
    end
    deleteTestingEmail
  end

  def testWizardQuestions
    @browser.goto @testSite
    @generalTools.waitOrCrash('Where are you located?')
    validatedQuestion1 = testZipCityState
    update_report('[Fitness Landing Page] Validating: "Where are you located?"',
                        validatedQuestion1)

    @generalTools.waitOrCrash('What type of training would you like?')
    validatedQuestion2 = testWhatTraining
    update_report('[Fitness Landing Page] Validating: "What type of training would you like?"',
                        validatedQuestion2)

    @generalTools.waitOrCrash("What's your training goal?")
    validatedQuestion3 = testTrainingGoal
    update_report('[Fitness Landing Page] Validating: "' + "What's your training goal?" + '"',
                        validatedQuestion3)

    doneMessage = @generalTools.waitOrCrash('Here are some fitness classes you might be interested in.')
    update_report('[Fitness Landing Page] Wizard done message is appearing',
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
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    validated = @generalTools.wait('Please select a training type')
    @generalTools.waitOrCrash('//*[@id="workoutsRadioOption"]',0,true)
    @browser.radio(:id,'workoutsRadioOption').set
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    sleep 1
    return validated
  end

  def testTrainingGoal
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    validated = @generalTools.wait('Please select a goal.')
    @generalTools.waitOrCrash('//*[@id="strengthRadioOption"]',0,true)
    @browser.radio(:id,'strengthRadioOption').set
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