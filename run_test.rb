class RunTest
  def initialize
    run_test = LocalRunTest.new()
    run_test.runTests()
  
    system('exit 0')
  end
end

