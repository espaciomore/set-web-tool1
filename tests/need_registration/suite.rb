class Tests_NeedRegistration_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_NeedRegistration_Users_Suite,
            Tests_NeedRegistration_AbleSentry_Suite,
            Tests_NeedRegistration_Whitehouse_Suite,
            ]
    $scheduler.add(@tests)
  end
end