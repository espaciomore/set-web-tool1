class Tests_StaticPages_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_StaticPages_NoodleProsCareTest,
            Tests_StaticPages_NewYorkSatTest,
            ]
    $scheduler.add(@tests, true)
  end
end