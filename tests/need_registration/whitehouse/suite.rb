class Tests_NeedRegistration_Whitehouse_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_NeedRegistration_Whitehouse_StudentslikemeTest,
            ]
    
    $scheduler.add(@tests)
  end
end