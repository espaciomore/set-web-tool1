class Tests_NeedRegistration_Users_Suite
  attr_accessor :tests
  
  def test
    @tests = [
             Tests_NeedRegistration_Users_Registration,
             Tests_NeedRegistration_Users_HomeTest,
             Tests_NeedRegistration_Users_FavoritesTest,
            ]
    $scheduler.add(@tests)
  end
end