class Lib_Forms_Fields_AcademicTestName < Lib_Forms_Field
  def getSupportedValue
    return 'SAT Modern Hebrew'
  end

  def getUnsupportedValue
    return 'invalid'
  end

  def validateText
    return 'Please insert valid values'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_AcademicTestName.new
    end
    return @instance
  end

  def setValue(tools, name, value)
    tools.watir_helper.reset.text_field(:name => name).typeBySet value
  end
end