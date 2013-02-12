class Lib_Forms_Fields_Language < Lib_Forms_Fields_AutoComplete
  
  def getSupportedValue
    return 'English'
  end

  def getUnsupportedValue
    return 'invalid'
  end

  def validateText
    return 'Please insert valid values'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_Language.new
    end
    return @instance
  end

  def setValue(tools, name, value)
    tools.watir_helper.reset.text_field(:name => name).type value
  end
end