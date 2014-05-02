set-web-tools1
==============

A tool created for developing frontend user acceptance tests using watir and selenium-webdriver


Dependencies
============

gem install rake rubygems hpricot selenium-webdriver watir-webdriver net-http json net-ssh net-scp tlsmail


User Guide
==========

From the project directory, use irb to generate file:

	# irb 
	> require 'set-web-tool1'
	> rake dir=/home/guest/project/
	
Then use the main.rb file to run test, for example:

	# ruby main.rb RunTest