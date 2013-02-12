class Lib_Forms_Fields_RadioButton < Lib_Forms_Field

  def getSupportedValue
    return false
  end

  def getUnsupportedValue
    return false
  end

  def validateText
    return 'Please insert valid values'
  end

  def self.getInstance
    unless @radioButton
      @radioButton = Lib_Forms_Fields_RadioButton.new
    end
    return @radioButton
  end

  def setValue(tools, id, value)
    tools.watir_helper.reset.radio(:id => id).set
  end
end