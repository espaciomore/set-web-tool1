class RunTest
  def initialize(settings, args)
    run_test = LocalRunTest.new(settings, args)
    run_test.runTests()
  
    system('exit 0')
  end
end

