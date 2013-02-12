class Tests_Marketing_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_Marketing_SweepstakesTest,
            ]
            
    $scheduler.add(@tests)      
  end
end