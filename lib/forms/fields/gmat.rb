class Lib_Forms_Fields_Gmat < Lib_Forms_Field

  def getSupportedValue
    return 800
  end

  def getUnsupportedValue
    return 199
  end

  def validateText
    return 'Please insert valid values'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_Gmat.new
    end
    return @instance
  end

  def setValue(tools, name, value)
    _watirHelper = tools.watir_helper.reset
    _watirHelper.text_field(:name => name).type value
  end
end