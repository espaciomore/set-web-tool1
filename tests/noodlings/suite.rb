class Tests_Noodlings_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_Noodlings_NoodlingPageTest,
            ]
    $scheduler.add(@tests)
  end
end