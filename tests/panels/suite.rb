class Tests_Panels_Suite 
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_Panels_AcademicTutoring_PanelTest,
            Tests_Panels_K12_PanelTest,
            Tests_Panels_StudyAbroad_PanelTest,
            ]
    
    $scheduler.add(@tests)  
  end
end