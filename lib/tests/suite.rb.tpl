class Tests_Suite
  attr_accessor :tests
  
  def test
    @tests = [
              Tests_Google_ExampleTest,
            ]
    
    $scheduler.add(@tests)   
    
    #*************************************
        
    @tests = [  
            ]
           
    $scheduler.add(@tests,true)
  end
end