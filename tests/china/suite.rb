class Tests_China_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_China_LandingPageTest,
            ]
    
    $scheduler.add(@tests, true)
  end 
end