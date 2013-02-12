class Lib_Tools_EntityProfile
  def initialize(tools)
    @browser = tools.browser
    @generalTools = tools
    @watir_helper = tools.watir_helper
    @report = tools.report  
  end
  
  def overallTest
    raise NotImplementedError
  end
  
  def rightRailTest  
    raise NotImplementedError
  end
  
  def tabsTest (tabs=[])
    raise NotImplementedError
  end
  
  def profileImageTest
    raise NotImplementedError
  end

  def profileFitScore
    raise NotImplementedError
  end
  
  def socialNetworkTest target
    raise NotImplementedError   
  end
  
  def linkedInModuleTest
    raise NotImplementedError
  end
end