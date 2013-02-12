class Lib_Forms_Fields_University < Lib_Forms_Fields_AutoComplete

  attr_accessor :university
    
  def setUniversity (name)
    @university = name
    return self
  end
  
  def getSupportedValue
    if @university
      return @university
    else
      return 'Yale University'
    end
  end

  def getUnsupportedValue
    return 'invalid'
  end

  def validateText
    return 'Please insert valid values'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_University.new
    end
    return @instance
  end
  
  def setValue(tools, selector, value)
    _watirHelper = tools.watir_helper
    _watirHelper.reset.text_field(:name => selector).typeBySet value
    _watirHelper.reset.link(:text => value).click
  end
end