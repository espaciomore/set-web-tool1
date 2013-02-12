class Tests_LandingPages_ArtDesign_AdLandingPageTest < Lib_Tests_LandingPagesAcceptanceTest

  def getReportPath
    return Config_Paths::LANDING_PAGES_REPORT_FOLDER_PATH + '/art_design/art_design'
  end

  def runTest
    @vertical = 'art-design'
    @testSite = $target_server + '/' + @vertical
    periodicTableXpath = '//*[@id="periodicTable"]/tbody/tr[5]/td[3]/div/div/div[1]/a'
    pageUrl = $target_server + '/artDEsiGn'

    @artDesignPage = Hash.new
    @artDesignPage['Periodic Table navigation'] = testPeriodicTableNavigation periodicTableXpath
    @artDesignPage['Going directly to url'] = testOpenPageByUrl pageUrl
    @artDesignPage['Breadcrumb item'] = testBreadcrumb
    @artDesignPage['Bing search'] = testBingResults
    @artDesignPage['Wizard'] = testWizardQuestions
    @artDesignPage['Overlay'] = testOverlay
    @artDesignPage['Email validation'] = testEmailValidation
    @artDesignPage['Recommended verticals'] = testRecommendedVerticals
    @artDesignPage['Join Noodle'] = testJoinNoodle
    @artDesignPage.each do|result,value|
      text = "[Art & Design Landing Page][cherry-hill-mall] Test that " + result + " is working"
      update_report(text, value)
    end
    deleteTestingEmail
  end

  def testWizardQuestions
    @browser.goto @testSite
    @generalTools.waitOrCrash('Where are you located?')
    validatedQuestion1 = testZipCityState
    update_report('[Art & Design Landing Page] Validating: "Where are you located?"',
                        validatedQuestion1)

    @generalTools.waitOrCrash('What type of art or design class would you like to take?')
    validatedQuestion2 = testWhatArtDesign
    update_report('[Art & Design Landing Page] Validating: "What type of art or design class would you like to take?"',
                        validatedQuestion2)

    @generalTools.waitOrCrash("What's your skill level?")
    validatedQuestion3 = testSkillLevel
    update_report('[Art & Design Landing Page] Validating: "' + "What's your skill level?" + '"',
                        validatedQuestion3)

    doneMessage = @generalTools.waitOrCrash('design resources you might be interested in.')
    update_report('[Art & Design Landing Page] Wizard done message is appearing',
                        doneMessage)

    if(doneMessage)
      validatedStartOver = testStartOver('Where are you located?')
    else
      validatedStartOver = false
    end
    return validatedQuestion1 && validatedQuestion2 && validatedQuestion3 && doneMessage && validatedStartOver
  end

  def testWhatArtDesign
    @generalTools.waitOrCrash('//*[@id="questionsStep2"]',0,true)
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    validated = @generalTools.wait('Please select a category.')
    @generalTools.waitOrCrash('//*[@id="performingArtsRadioOption"]',0,true)
    @browser.radio(:id,'performingArtsRadioOption').set
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    sleep 1
    return validated
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