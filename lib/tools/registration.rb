class Lib_Tools_Registration 
  def initialize(tools, register_user)
    @report = tools.report
    @browser = tools.browser
    @generalTools = tools
    @watir_helper = tools.watir_helper
    @registeredName = 'Noodle RegisterTest'
    @registeredEmail = register_user
    @registeredPassword = '123456' 
    @registeredBirthMonth = 'July'
    @registeredBirthDay = '14'
    @registeredBirthYear = '1986'
  end
    
  def removeUser(email=@registeredEmail)
    begin
      url = "#{$target_server}/web_services/acceptance_tests/handler.php?action=delete_user&parameters=#{email}"
      result = Net::HTTP.get URI.parse(url)
      _success = result.include?('success')
    rescue
      _success = false
    end
    return _success
  end
end