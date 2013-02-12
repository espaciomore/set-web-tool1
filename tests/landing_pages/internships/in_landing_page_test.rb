class Tests_LandingPages_Internships_InLandingPageTest < Lib_Tests_LandingPagesAcceptanceTest

  def getReportPath
    return Config_Paths::LANDING_PAGES_REPORT_FOLDER_PATH + '/internships/internships'
  end

  def runTest
    @vertical = 'internships'
    @testSite = $target_server + '/' + @vertical
    periodicTableXpath = '//*[@id="periodicTable"]/tbody/tr[2]/td[8]/div/div/div[1]/a'
    pageUrl = $target_server + '/internships'

    @internshipsPage = Hash.new
    @internshipsPage['Periodic Table navigation'] = testPeriodicTableNavigation periodicTableXpath
    @internshipsPage['Going directly to url'] = testOpenPageByUrl pageUrl
    @internshipsPage['Breadcrumb item'] = testBreadcrumb
    @internshipsPage['Bing search'] = testBingResults
    @internshipsPage['Wizard'] = testWizardQuestions
    @internshipsPage['Overlay'] = testOverlay
    @internshipsPage['Email validation'] = testEmailValidation
    @internshipsPage['Recommended verticals'] = testRecommendedVerticals
    @internshipsPage['Join Noodle'] = testJoinNoodle
    @internshipsPage.each do|result,value|
      text = "[Internships Landing Page][south-cortland] Test that " + result + " is working"
      update_report(text, value)
    end
    deleteTestingEmail
  end

  def testWizardQuestions
    @browser.goto @testSite
    @generalTools.waitOrCrash('Where are you located?')
    validatedQuestion1 = testZipCityState
    update_report('[Internships Landing Page] Validating: "Where are you located?"',
                        validatedQuestion1)

    @generalTools.waitOrCrash('What type of internship are you looking for?')
    validatedQuestion2 = testWhatInternship
    update_report('[Internships Landing Page] Validating: "What type of internship are you looking for?"',
                        validatedQuestion2)

    @generalTools.waitOrCrash("I'm interested in:")
    validatedQuestion3 = testInterestedIn
    update_report('[Internships Landing Page] Validating: "' + "I'm interested in:" + '"',
                        validatedQuestion3)

    @generalTools.waitOrCrash('What type of compensation are you looking for?')
    validatedQuestion4 = testCompensation
    update_report('[Internships Landing Page] Validating: "What type of compensation are you looking for?"',
                        validatedQuestion4)

    doneMessage = @generalTools.waitOrCrash('Here are some internship resources you might be interested in.')
    update_report('[Internships Landing Page] Wizard done message is appearing',
                        doneMessage)

    if(doneMessage)
      validatedStartOver = testStartOver('Where are you located?')
    else
      validatedStartOver = false
    end
    return validatedQuestion1 && validatedQuestion2 && validatedQuestion3 && validatedQuestion4 && doneMessage && validatedStartOver
  end

  def testWhatInternship
    @generalTools.waitOrCrash('//*[@id="questionsStep2"]',0,true)
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    validated = @generalTools.wait('Please select an internship type.')
    @generalTools.waitOrCrash('//*[@id="professionalRadioOption"]',0,true)
    @browser.radio(:id,'professionalRadioOption').set
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    return validated
  end

  def testInterestedIn
    @generalTools.waitOrCrash('//*[@id="questionsStep3"]',0,true)
    xpath = '//*[@id="question3Dropdown"]/select'
    options = @browser.select_list(:xpath, xpath).elements
    @browser.select_list(:xpath, xpath).select options[3].text
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    sleep 1
    return true
  end

  def testCompensation
    @generalTools.waitOrCrash('//*[@id="questionsStep4"]',0,true)
    @browser.span(:xpath,'//*[@id="questionsStep4"]/span/span/span').click
    validated = @generalTools.wait('Please select a type of compensation.')
    @generalTools.waitOrCrash('//*[@id="paidRadioOption"]',0,true)
    @browser.radio(:id,'paidRadioOption').set
    @browser.span(:xpath,'//*[@id="questionsStep4"]/span/span/span').click
    return validated
  end

  def testRecommendedVerticals
    @browser.goto @testSite
    tutoringXpath = '//*[@id="sidebar-right"]/div[1]/div/p[1]/a'
    highSchoolXpath = '//*[@id="sidebar-right"]/div[1]/div/p[2]/a'
    collegeXpath = '//*[@id="sidebar-right"]/div[1]/div/p[3]/a'
    @generalTools.waitOrCrash(tutoringXpath,0,true)
    @browser.link(:xpath,tutoringXpath).click
    tutoring = @generalTools.waitUrl($target_server + '/find/tutoring')

    @browser.goto @testSite
    @generalTools.waitOrCrash(highSchoolXpath,0,true)
    @browser.link(:xpath,highSchoolXpath).click
    highSchool = @generalTools.waitUrl($target_server + '/k-12')

    @browser.goto @testSite
    @generalTools.waitOrCrash(collegeXpath,0,true)
    @browser.link(:xpath,collegeXpath).click
    college = @generalTools.waitUrl($target_server + '/find/college')
    return tutoring && highSchool && college
  end
end