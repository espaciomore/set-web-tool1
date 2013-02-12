class Tests_SignInOut_ValidationTest < Lib_Tests_AcceptanceTest

  def testLoggedIn
    return false
  end

  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/sign_in_out/sign_in_validation'
  end

  def runTest
    testLoginValidation
  end

  attr_accessor :main
  attr_accessor :context

  def testLoginValidation()
    @main = "abstractHeader"
    update_report("[User Sign In Validation] Test that user input is validating sign in on general site",
                  signIn.withTestUser)

    @main = "registrationStandalone"
    @watir_helper.goto "#{$target_server}/register"
    update_report("[User Sign In Validation] Test that user input is validating sign in on register site",
                  signInHere.withTestUser)
  end

  def onMain
    return @watir_helper.reset.div(:xpath => '//*[@id="'+@main+'"]')
  end

  def onSignIn
    return @watir_helper.reset.div(:xpath => '//*[@id="accountMenu"]')
  end

  def onSignInOverlay
    return @watir_helper.reset.div(:xpath => '//*[@id="loginOverlayContainer"]')
  end

  def centerWrapper
    onMain
    return self
  end

  def signIn
    onMain.link(:xpath => '//*[@id="account"]/a').click
    sleep 2
    onSignIn.waitOnEval("style?('display: block;')")
    @context = :onSignIn
    return self
  end

  def signInHere
    onMain.abutton(:text => 'Sign in here').click
    sleep 2
    onSignInOverlay.waitOnEval("style?('display: block;')")
    @context = :onSignInOverlay
    return self
  end

  def withTestUser
    begin
      _isValid = self.send(@context).text_field(:id => 'user').exists?
      _isValid = (_isValid && self.send(@context).text_field(:id => 'user').value=="Email")
      _isValid = (_isValid && self.send(@context).text_field(:class => 'passwordLabel tk-ff-univers-bold').value=="Password")
      self.send(@context).text_field(:id => 'user').type "noodle@123"
      self.send(@context).text_field(:class => 'passwordLabel tk-ff-univers-bold').set "12"
      sleep 1
      self.send(@context).text_field(:id => 'pass').set "12"
      self.send(@context).span(:text => 'Sign in').click
      sleep 1
      _errorMsg = (self.send(@context).find(:class => 'errorMessage').waitOnEval("style?('display: block;')") ||
                  self.send(@context).div(:class => 'errBalloon errTooltipBalloon errBalloon_visible').visible?)
      _isValid = (_isValid && _errorMsg)
    rescue
      _isValid = false
    end
    return _isValid
  end
end