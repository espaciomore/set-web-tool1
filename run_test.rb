require File.dirname(__FILE__) + "/bootstrap.rb"
require File.dirname(__FILE__) + "/local_run_test.rb"

run_test = LocalRunTest.new()
run_test.runTests()

system('exit 0')

