class Lib_Forms_Fields_ComboBox < Lib_Forms_Fields_Selects

  attr_accessor :option
    
  def setOption(number)
    @option = number
    return self
  end
  
  def getSupportedValue
    if @option
      return @option
    else 
      return 1
    end
  end

  def getUnsupportedValue
    return 0
  end

  def validateText
    return 'Please insert valid values'
  end
  
  def self.getInstance
    unless @comboBox
      @comboBox = Lib_Forms_Fields_ComboBox.new
    end
    return @comboBox
  end

end