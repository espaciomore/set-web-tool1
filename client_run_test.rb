#!/usr/bin/env ruby
#
# Created on Nov / 12 / 2012
#
# @author ManuelCerda
require File.dirname(__FILE__) + '/config/configuration.rb'
require File.dirname(__FILE__) + "/lib/client.rb"

class ClientRunTest
  
  def initialize()
    STDOUT.sync = true
    self::run()
  end   

  def run()
    while(true)
      $stdout.flush
      system("git pull")
          
      run_test = Lib_Client.new()
      run_test.startServerSocket Configuration::PORT
      
      if ([0,6].include?(Date.today.wday))
        break 
      end
    end 
  end
end

run_test = ClientRunTest.new()

exec('init 0')