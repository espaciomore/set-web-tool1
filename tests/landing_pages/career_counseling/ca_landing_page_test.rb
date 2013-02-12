class Tests_LandingPages_CareerCounseling_CaLandingPageTest < Lib_Tests_LandingPagesAcceptanceTest

  def getReportPath
    return Config_Paths::LANDING_PAGES_REPORT_FOLDER_PATH + '/career_counseling/career_counseling'
  end

  def runTest
    @vertical = 'career-counseling'
    @testSite = $target_server + '/' + @vertical
    periodicTableXpath = '//*[@id="periodicTable"]/tbody/tr[5]/td[8]/div/div/div[1]/a'
    pageUrl = $target_server + '/cAReERCouNselING'

    @careerCounselingPage = Hash.new
    @careerCounselingPage['Periodic Table navigation'] = testPeriodicTableNavigation periodicTableXpath
    @careerCounselingPage['Going directly to url'] = testOpenPageByUrl pageUrl
    @careerCounselingPage['Breadcrumb item'] = testBreadcrumb
    @careerCounselingPage['Bing search'] = testBingResults
    @careerCounselingPage['Wizard'] = testWizardQuestions
    @careerCounselingPage['Overlay'] = testOverlay
    @careerCounselingPage['Email validation'] = testEmailValidation
    @careerCounselingPage['Recommended verticals'] = testRecommendedVerticals
    @careerCounselingPage['Join Noodle'] = testJoinNoodle
    @careerCounselingPage.each do|result,value|
      text = "[Career Counseling Landing Page][spurgeon] Test that " + result + " is working"
      update_report(text, value)
    end
    deleteTestingEmail
  end

  def testWizardQuestions
    @browser.goto @testSite
    @generalTools.waitOrCrash('Where are you located?')
    validatedQuestion1 = testZipCityState
    update_report('[Career Counseling Landing Page] Validating: "Where are you located?"',
                        validatedQuestion1)

    @generalTools.waitOrCrash('I would like advice on the following career field:')
    validatedQuestion2 = testCareerField
    update_report('[Career Counseling Landing Page] Validating: "I would like advice on the following career field:"',
                        validatedQuestion2)

    @generalTools.waitOrCrash("What's your level of professional experience?")
    validatedQuestion3 = testProfessionalLevel
    update_report('[Career Counseling Landing Page] Validating: "' + "What's your level of professional experience?"+ '"',
                        validatedQuestion3)

    doneMessage = @generalTools.waitOrCrash('Here are some career counseling resources you might be interested in.')
    update_report('[Career Counseling Landing Page] Wizard done message is appearing',
                        doneMessage)

    if(doneMessage)
      validatedStartOver = testStartOver('Where are you located?')
    else
      validatedStartOver = false
    end
    return validatedQuestion1 && validatedQuestion2 && validatedQuestion3 && doneMessage && validatedStartOver
  end

  def testCareerField
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

  def testProfessionalLevel
    @generalTools.waitOrCrash('//*[@id="questionsStep3"]',0,true)
    xpath = '//*[@id="question3Dropdown"]/select'
    options = @browser.select_list(:xpath, xpath).elements
    @browser.select_list(:xpath, xpath).select options[0].text
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    validated = @generalTools.wait('Please select an experience level')
    @browser.select_list(:xpath, xpath).select options[2].text
    @browser.span(:xpath,'//*[@id="questionsStep3"]/span/span/span').click
    sleep 1
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