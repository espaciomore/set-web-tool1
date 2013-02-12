class Tests_Leads_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_Leads_ManageYourLeadsTest,
            ]
            
    $scheduler.add(@tests)      
  end
end