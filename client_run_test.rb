require File.dirname(__FILE__) + "/config/bootstrap.rb"

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
          
      startServerSocket Configuration::PORT
      
      if ([0,6].include?(Date.today.wday))
        break 
      end
    end 
  end
end

run_test = ClientRunTest.new()

exec('init 0')