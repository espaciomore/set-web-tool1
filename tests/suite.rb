class Tests_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            ]
    
    $scheduler.add(@tests)   
    
    #*************************************
        
    @tests = [  
            ]
           
    $scheduler.add(@tests,true)
  end
end