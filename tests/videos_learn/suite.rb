class Tests_VideosLearn_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_VideosLearn_LearnPageTest,
            Tests_VideosLearn_DetailsPageTest,
            ]
    
    $scheduler.add(@tests, true)
  end  
end