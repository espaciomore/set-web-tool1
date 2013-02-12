class Tests_MonitoringService_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_MonitoringService_GeneralMonitoring,
            ]
    
    $scheduler.add(@tests, true)
  end 
end