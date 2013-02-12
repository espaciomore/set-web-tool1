class Lib_Tools_LogOut
  def initialize(tools)
    @generalTools = tools
    @browser = tools.browser    
  end
  
  def logout()
    raise NotImplementedError
  end 
end