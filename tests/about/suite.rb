class Tests_About_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_About_AboutNoodleTest,
            ]
    
    $scheduler.add(@tests)
  end
end