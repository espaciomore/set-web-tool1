begin
  $__GEM__ = File.dirname(__FILE__)
	load $__GEM__ +"/bootstrap.rb"
rescue LoadError => error
	raise error
end

class << self
	def hello
		"hi"
	end
	
	def create_test_scaffold(settings, args)
		TestScaffold.new(settings, args)
	end
	
	def exec_test(settings, args)
	  RunTest.new(settings, args)
	end
end
