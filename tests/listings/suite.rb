class Tests_Listings_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            #Tests_Listings_ManageYourListingsTest,
            Tests_Listings_ListsPageTest,
            Tests_Listings_CreateListingTest,
            ]
            
    $scheduler.add(@tests) 
  end
end