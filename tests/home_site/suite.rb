class Tests_HomeSite_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_HomeSite_HomepageTest,
            ]
    $scheduler.add(@tests)
  end
end