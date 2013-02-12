class Tests_LandingPages_StudentTravel_StLandingPageTest < Lib_Tests_LandingPagesAcceptanceTest

  def getReportPath
    return Config_Paths::LANDING_PAGES_REPORT_FOLDER_PATH + '/student_travel/student_travel'
  end

  def runTest
    @vertical = 'student-travel'
    @testSite = $target_server + '/' + @vertical
    periodicTableXpath = '//*[@id="periodicTable"]/tbody/tr[6]/td[1]/div/div/div[1]/a'
    pageUrl = $target_server + '/STudenTTravel'

    @studentTravelPage = Hash.new
    @studentTravelPage['Periodic Table navigation'] = testPeriodicTableNavigation periodicTableXpath
    @studentTravelPage['Going directly to url'] = testOpenPageByUrl pageUrl
    @studentTravelPage['Breadcrumb item'] = testBreadcrumb
    @studentTravelPage['Bing search'] = testBingResults
    @studentTravelPage['Wizard'] = testWizardQuestions
    @studentTravelPage['Overlay'] = testOverlay
    @studentTravelPage['Email validation'] = testEmailValidation
    @studentTravelPage['Recommended verticals'] = testRecommendedVerticals
    @studentTravelPage['Join Noodle'] = testJoinNoodle
    @studentTravelPage.each do|result,value|
      text = "[Student Travel Landing Page][pleasant-home] Test that " + result + " is working"
      update_report(text, value)
    end
    deleteTestingEmail
  end

  def testWizardQuestions
    @browser.goto @testSite
    @generalTools.waitOrCrash('Where would you like to travel?')
    validatedQuestion1 = testZipCityState
    update_report('[Student Travel Landing Page][pleasant-home] Validating: "Where would you like to travel?"',
                        validatedQuestion1)

    @generalTools.waitOrCrash("What's your language of choice?")
    validatedQuestion2 = testLanguageChoice
    update_report('[Student Travel Landing Page][pleasant-home] Validating: "What'+ "'s your language of choice?" + '"',
                        validatedQuestion2)

    @generalTools.waitOrCrash('How long do you want to be traveling?')
    validatedQuestion3 = testWantTravel
    update_report('[Student Travel Landing Page][pleasant-home] Validating: "How long do you want to be traveling?"',
                        validatedQuestion3)

    doneMessage = @generalTools.waitOrCrash('Here are some student travel programs you might be interested in.')
    update_report('[Student Travel Landing Page][pleasant-home] Wizard done message is appearing',
                        doneMessage)

    if(doneMessage)
      validatedStartOver = testStartOver('Where would you like to travel?')
    else
      validatedStartOver = false
    end
    return validatedQuestion1 && validatedQuestion2 && validatedQuestion3 && doneMessage && validatedStartOver
  end



  def testLanguageChoice
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    validated = @generalTools.wait('Please select a language.');
    @generalTools.waitOrCrash('//*[@id="nativeLanguageRadioOption"]',0,true)
    @browser.radio(:id,'nativeLanguageRadioOption').set
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    sleep 1
    return validated
  end

  def testWantTravel
    @generalTools.waitOrCrash('//*[@id="questionsStep3"]',0,true)
    xpath = '//*[@id="question3Dropdown"]/select'
    options = @browser.select_list(:xpath, xpath).elements
    @browser.select_list(:xpath, xpath).select options[2].text
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    sleep 1
    return true
  end

  def testRecommendedVerticals
    @browser.goto @testSite
    highSchoolXpath = '//*[@id="sidebar-right"]/div[1]/div/p[1]/a'
    collegeXpath = '//*[@id="sidebar-right"]/div[1]/div/p[2]/a'
    tutoringXpath = '//*[@id="sidebar-right"]/div[1]/div/p[3]/a'
    @generalTools.waitOrCrash(highSchoolXpath,0,true)
    @browser.link(:xpath,highSchoolXpath).click
    highSchool = @generalTools.waitUrl($target_server + '/k-12')

    @browser.goto @testSite
    @generalTools.waitOrCrash(collegeXpath,0,true)
    @browser.link(:xpath,collegeXpath).click
    college = @generalTools.waitUrl($target_server + '/find/college')

    @browser.goto @testSite
    @generalTools.waitOrCrash(tutoringXpath,0,true)
    @browser.link(:xpath,tutoringXpath).click
    tutoring = @generalTools.waitUrl($target_server + '/find/tutoring')

    return highSchool && college && tutoring
  end
end