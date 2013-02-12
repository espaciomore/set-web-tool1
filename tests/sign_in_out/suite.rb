class Tests_SignInOut_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_SignInOut_FacebookConnectTest,
            Tests_SignInOut_SignInOutTest,
            Tests_SignInOut_ValidationTest,
            ]
            
    $scheduler.add(@tests)
  end
end