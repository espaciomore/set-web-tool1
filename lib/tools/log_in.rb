class Lib_Tools_LogIn
  def initialize(tools)
    @generalTools = tools
    @browser = tools.browser
    @watir_helper = tools.watir_helper
  end
  
  def login(params)
    raise NotImplementedError
  end 
end