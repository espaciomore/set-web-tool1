class Lib_Tools_LogOutFactory < Lib_Tools_LogOut
  
  def logout()
    _logout = true
    if $isLoggedIn
      begin
        @browser.span(:xpath => '//*[@id="account"]/span').hover
        @generalTools.wait('//*[@class="menuButton active"]', 5, true)
        @browser.link(:xpath => '//*[@id="accountMenu"]/ul/li[3]/div/a').click
        _logout = @generalTools.waitUrl("#{$target_server}/", 3)
      rescue
        _logout = false
      end
    end
    return _logout
  end 
end