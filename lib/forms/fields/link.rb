class Lib_Forms_Fields_Link < Lib_Forms_Field
  
  def getSupportedValue
    return false
  end

  def getUnsupportedValue
    return false
  end

  def validateText
    return false
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_Link.new
    end
    return @instance
  end

  def setValue(tools, xpath, value)
    _watirHelper = tools.watir_helper.reset
    _watirHelper.abutton(:xpath => xpath).click 
  end
end