class Tests_Modules_Suite 
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_Modules_HeaderTest,
            Tests_Modules_FooterTest,
            Tests_Modules_GeneralSearchTest,
            #Tests_Modules_EntityProfilesTest,
            #Tests_Modules_GridItemsTest,
            #Tests_Modules_PeriodicTableTest,
            ]
    
    $scheduler.add(@tests)
  end
end