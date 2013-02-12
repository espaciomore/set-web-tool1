module Lib_Modules_ClientConnection
  def startServerSocket(port)
    print "\nWaiting for Connection on port: #{port}\n\r"
    serverFactory = TCPServer.new("0.0.0.0", port) # => It's necessary to bind to all IP address to avoid connection refused 
    loop do
       canBreak = false
       Thread.start(serverFactory.accept) do |_conn| 
        	  _execStr = _conn.gets.strip        
        	  if _execStr.include?("Tests_")
        	    system("git pull")
        	    system("#{_execStr}")
        	    _conn.print "getReportInfo()\r\n"  # => getReportInfo(),"\r\n"
        	    _conn.flush  
        	  elsif _execStr.include?('testing port')  
        	    #nothing
        	  else        	        
              if ([0,6].include?(Date.today.wday))
                canBreak = true
              end  
        	  end
        	 _conn.gets              
        end
        if canBreak
          break
        end
    end  
  end
end
