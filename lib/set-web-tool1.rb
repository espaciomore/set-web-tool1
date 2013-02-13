begin
	require "./bootstrap.rb"
rescue LoadError => error
	puts "#{error}"
end

class << self
	def hello
		"hi"
	end
	
	def create_test_scaffold(root_path, klass_name)
		TestScaffold.new(root_path, klass_name)
	end
end
