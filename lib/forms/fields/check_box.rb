class Lib_Forms_Fields_CheckBox < Lib_Forms_Field

  def getSupportedValue
    return true
  end

  def getUnsupportedValue
    return false
  end

  def validateText
    return 'Please insert valid values'
  end

  def setValue(tools, id, value)
    _watirHelper = tools.watir_helper.reset
    _watirHelper.checkbox(:id => id).set 
  end

  def self.getInstance
    unless @checkBox
      @checkBox = Lib_Forms_Fields_CheckBox.new
    end
    return @checkBox
  end
end