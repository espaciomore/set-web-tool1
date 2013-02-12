class Lib_Forms_Fields_Lsat < Lib_Forms_Field

  def getSupportedValue
    return 180
  end

  def getUnsupportedValue
    return 1
  end

  def validateText
    return 'Please insert valid values'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_Lsat.new
    end
    return @instance
  end

  def needsWaitTime
    return 2
  end
  
  def setValue(tools, name, value)
    _watirHelper = tools.watir_helper
    _watirHelper.reset.text_field(:name => name).type value
  end
end