begin
	require "./bootstrap.rb"
rescue LoadError => error
	puts "#{error}"
end

# => After loading the bootstrap you can do something like: ClientRunTest.new