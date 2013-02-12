class Tests_NeedRegistration_AbleSentry_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_NeedRegistration_AbleSentry_WizardThenSignup,
            ]
    $scheduler.add(@tests)
  end
end