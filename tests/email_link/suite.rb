class Tests_EmailLink_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_EmailLink_ForgotPasswordTest,
            ]
    
    $scheduler.add(@tests, true)
  end 
end