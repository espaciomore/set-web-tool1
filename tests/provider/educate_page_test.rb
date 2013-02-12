class Tests_Provider_EducatePageTest < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/provider/educate_landing_page'
  end
  
  def testLoggedIn
    return false
  end
  
  def testSite
    "#{$target_server}/educate"
  end
  
  def runTest
    update_report("[Educate Landing Page] Test that user can see landing page backgroung image",
                  testBGImage)
    update_report("[Educate Landing Page] Test that user can see landing page title",
                  testBigTitle)
    update_report("[Educate Landing Page] Test that user can see landing page description",
                  testDescription) 
    update_report("[Educate Landing Page] Test that user can use links to register as provider",
                  testCreateAccountLink)
  end  
  
  def testBGImage
    _image = onTopBody.image(:xpath => 'img')
    _image.exists? ? _image.loaded? : false
  end
  
  def testBigTitle
    _title = onTopBody.h2(:xpath => 'div/h2')
    _title.exists? ? _title.text.include?('Students Are Looking For You') : false
  end

  def testDescription
    _description = onTopBody.p(:xpath => 'div/p')
    _description.exists? ? _description.text.include?('Noodle allows tutors, consultants, coaches') : false
  end

  def testCreateAccountLink
    _createAccount = onTopBody.link(:xpath => 'div/a')
    _createAccount.click
    _success = @watir_helper.urlLike("#{$target_server}/educate/sign-up")
    @watir_helper.go_back_to testSite
    _createAccount = onTopBody.link(:xpath => '//*[@id="bottomContainer"]/a')
    _createAccount.click    
    _success = _success && @watir_helper.urlLike("#{$target_server}/educate/sign-up")
    _success
  end
      
  def onTopBody
    @watir_helper.reset.div(:xpath => '//*[@id="educateHeaderContainer"]')
  end
end