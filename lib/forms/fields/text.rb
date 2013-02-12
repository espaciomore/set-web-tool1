class Lib_Forms_Fields_Text < Lib_Forms_Field

  def getSupportedValue
    return "This is a test"
  end

  def getUnsupportedValue
    return ''
  end

  def setValue(tools, name, value)
    _watirHelper = tools.watir_helper    
    _watirHelper.reset.text_field(:name => name).type value
  end

  def validateText
    return 'Please insert valid values'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_Text.new
    end
    return @instance
  end
end