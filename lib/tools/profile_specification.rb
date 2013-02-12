class Lib_Tools_ProfileSpecification
  
  def initialize(tools)
    @browser = tools.browser
    @generalTools = tools
    @watir_helper = tools.watir_helper
    @report = tools.report  
  end
  
  def testBreadcrumb comp=nil
    raise NotImplementedError
  end
  
  def testProfileImage
    raise NotImplementedError
  end
  
  def testHeaderTitle text=''
    raise NotImplementedError
  end
  
  def update_report(description, reason)
    @generalTools.update_report(description, reason)    
  end  
end