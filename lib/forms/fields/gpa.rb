class Lib_Forms_Fields_Gpa < Lib_Forms_Field

  def getSupportedValue
    return '3.9'
  end

  def getUnsupportedValue
    return '4.1'
  end

  def validateText
    return 'Please insert valid values'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_Gpa.new
    end
    return @instance
  end

  def setValue(tools, name, value)
    _watirHelper = tools.watir_helper.reset
    _watirHelper.text_field(:name => name).type value
  end
end