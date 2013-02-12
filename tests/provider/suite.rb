class Tests_Provider_Suite
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_Provider_RegistrationTest,
            Tests_Provider_DashboardTest,
            Tests_Provider_ProfilesTest,
            Tests_Provider_EducatePageTest,
            ]
    
    $scheduler.add(@tests)
  end
end