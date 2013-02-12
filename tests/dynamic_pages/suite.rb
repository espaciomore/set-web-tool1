class Tests_DynamicPages_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_DynamicPages_JoinNoodlePageTest,
            Tests_DynamicPages_SatHelpPageTest,
            ]
    
    $scheduler.add(@tests, true)
  end 
end