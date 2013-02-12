class Tests_LandingPages_LanguageInstruction_LaLandingPageTest < Lib_Tests_LandingPagesAcceptanceTest

  def getReportPath
    return Config_Paths::LANDING_PAGES_REPORT_FOLDER_PATH + '/language_instruction/language_instruction'
  end

  def runTest
    @vertical = 'language-instruction'
    @testSite = $target_server + '/' + @vertical
    periodicTableXpath = '//*[@id="periodicTable"]/tbody/tr[6]/td[4]/div/div/div[1]/a'
    pageUrl = $target_server + '/lanGUAgeinSTRuction'

    @languageInstructionPage = Hash.new
    @languageInstructionPage['Periodic Table navigation'] = testPeriodicTableNavigation periodicTableXpath
    @languageInstructionPage['Going directly to url'] = testOpenPageByUrl pageUrl
    @languageInstructionPage['Breadcrumb item'] = testBreadcrumb
    @languageInstructionPage['Bing search'] = testBingResults
    @languageInstructionPage['Wizard'] = testWizardQuestions
    @languageInstructionPage['Overlay'] = testOverlay
    @languageInstructionPage['Email validation'] = testEmailValidation
    @languageInstructionPage['Recommended verticals'] = testRecommendedVerticals
    @languageInstructionPage['Join Noodle'] = testJoinNoodle
    @languageInstructionPage.each do|result,value|
      text = "[Language Instruction Landing Page][finger] Test that " + result + " is working"
      update_report(text, value)
    end
    deleteTestingEmail
  end

  def testWizardQuestions
    @browser.goto @testSite
    @generalTools.waitOrCrash('Where are you located?')
    validatedQuestion1 = testZipCityState
    update_report('[Language Instruction Landing Page] Validating: "Where are you located?"',
                        validatedQuestion1)

    @generalTools.waitOrCrash('What language do you want to learn?')
    validatedQuestion2 = testWhatLanguage
    update_report('[Language Instruction Landing Page] Validating: "What language do you want to learn?"',
                        validatedQuestion2)

    @generalTools.waitOrCrash("How do you want to study?")
    validatedQuestion3 = testWantStudy
    update_report('[Language Instruction Landing Page] Validating: "How do you want to study?"',
                        validatedQuestion3)

    doneMessage = @generalTools.waitOrCrash('Here are some language instruction resources you might be interested in')
    update_report('[Language Instruction Landing Page] Wizard done message is appearing',
                        doneMessage)

    if(doneMessage)
      validatedStartOver = testStartOver('Where are you located?')
    else
      validatedStartOver = false
    end
    return validatedQuestion1 && validatedQuestion2 && validatedQuestion3 && doneMessage && validatedStartOver
  end

  def testWhatLanguage
    @generalTools.waitOrCrash('//*[@id="questionsStep2"]',0,true)
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    validated = @generalTools.wait('Please select a language.')
    xpath = '//*[@id="languagePreferenceInput"]'
    @browser.text_field(:xpath, xpath).set 'ASDF'
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    validated = validated && @generalTools.wait('Please select a language.')
    @browser.text_field(:xpath, xpath).set 'English'
    @browser.span(:xpath,'//*[@id="questionsStep2"]/span/span/span').click
    sleep 1
    return validated
  end

  def testWantStudy
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    validated = @generalTools.wait('Please select a study setting')
    @generalTools.waitOrCrash('//*[@id="coursesRadioOption"]',0,true)
    @browser.radio(:id,'coursesRadioOption').set
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