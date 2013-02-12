require File.dirname(__FILE__) + "/bootstrap.rb"

class ClientRunTest
  
  include Lib_Modules_ClientConnection
  
  def initialize()
    STDOUT.sync = true
    self::run()
  end   

  def run()
    while(true)
      $stdout.flush
      system("git pull")
          
      startServerSocket Config_Settings::PORT
      
      if ([0,6].include?(Date.today.wday))
        break 
      end
    end 
  end
end

run_test = ClientRunTest.new()

exec('init 0')