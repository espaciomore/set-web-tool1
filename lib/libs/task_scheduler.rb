class Libs_TaskScheduler 
  
  attr_accessor :tests
  attr_accessor :threads
  attr_accessor :lock_
  
  def initialize()    
    @@tests = []
    @@threads = []    
    #@@execs = [] #j ust to generate symbolic link files
    @@lock_ = false # no instance has it
  end

  def add _tests,isThread=false     
    _tests.each do |test|      
      #@@execs << "touch #{test}"
      if isTest(test)  
        get_Lock
        addIt( test, isThread )
        put_Lock
      else          
        test.new.test
      end
    end
    
    return self
  end
    
  def schedule groupPriority=0
    count = 6
    main = Thread.new do
      Thread.current.priority = groupPriority
      @@threads.each do |test|   
        groupPriority -= 1   
        t = Thread.new do 
          Thread.current.priority = groupPriority
          Thread.current[:name] = "#{test}"
          test.new.test 
          Thread.stop  
        end   
        sleep count**2
        count += 2 
      end     
    end    
    main.join
    
    return self
  end
  
  def runTests(isServer=false)  
    if isServer
      _server = Libs_Server.new
      client_list = ($target_browser==:ie ? $settings.clients_ie : ($settings.clients + $settings.clients_ie))
      if _server.testService( client_list, @@tests, $settings.port )
        _server.waitingForReport
      end
    else     
      @@tests.each do |test_class|
        begin
          instance_eval File.open(getFilePath( test_class )+'.rb').read 
          Object.const_get(test_class).new.test
        rescue LoadError => error
          puts "\nError running #{test_class}: #{error}"
        end  
      end   
      #system @@execs.join(';')    
    end
    return self
  end
  
  def getTests
    return @@tests
  end

  def getThreads
    return @@threads
  end    
  
  private
  
  def usingThreads?
    return ($thread)
  end  
  
  def isTest test
    return !("#{test}".include?"Suite")
  end
  
  def addIt test,isThread   
    if (!isThread or !usingThreads?)
      (@@tests << test )
    end
    if (isThread and usingThreads?)    
      (@@threads << test )
    end
    return nil
  end
  
  def get_Lock
    while(@@lock_)   
      # just wait   
    end
    @@lock_ = true
  end
  
  def put_Lock
    @@lock_ = false
  end  
  
end