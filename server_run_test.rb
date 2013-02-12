#!/usr/bin/env ruby
#
# Created on Nov / 12 / 2012
#
# @author ManuelCerda

require 'date'

@@params = ARGV.join(' ')
@@_endless = @@params.include?('--endless')

class ServerRunTest
  
  def initialize()
    STDOUT.sync = true
    self::run()
  end   

  def run()
    while(true)
      $stdout.flush
      system("git pull")
      system("ruby run_test.rb #{@@params} --server")
      if ([0,6].include?(Date.today.wday) and false)   # => temporary set to false      
        sleep 60
        break 
      elsif !@@_endless
        break
      end
      sleep(25200) if @@_endless
    end 
  end
end

run_test = ServerRunTest.new()

#exec('init 0') if @@_endless