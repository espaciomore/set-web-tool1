class Tests_CompanyProfiles_Suite
  attr_accessor :tests

  def test
    @tests = [
              Tests_CompanyProfiles_NoodleProsListingsTest,
             ]

    $scheduler.add(@tests,true)
  end
end