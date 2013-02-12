class Lib_Tools_Reports 
  #attr_accessor :fileName
  attr_accessor :absolutePath  
  attr_accessor :finalPath  
  attr_accessor :testName
  attr_accessor :html
  attr_accessor :head
  attr_accessor :body
  attr_accessor :title
  attr_accessor :content
  attr_accessor :overallResult
  attr_accessor :testCount 
  attr_accessor :stringToWrite
  
  def initialize()    
  end
  
  def addToReport(step, arg, tool = 'none', action = 'none')
    raise NotImplementedError
  end
  
  def createReport(reportName)
    self::openReport(reportName)
  end
  
  def finishReport()
    self::closeReport()
  end
  
  def openReport(reportName)
    raise NotImplementedError
  end
  
  def closeReport()
    raise NotImplementedError
  end
  
  def send_report() 
    begin
      dir = '/var/www/html/continuous_delivery/acceptance_tests/sockets/reports'
      Net::SSH.start("10.0.0.29", "noodleqa", :password => "welc0me") do |ssh|
        ssh.scp.upload!("#{@absolutePath}", "#{dir}#{@finalPath}")
      end        
    rescue Exception => e
      puts "FAILED to send report: #{e}"
    end                  
  end  
end