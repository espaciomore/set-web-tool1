class Lib_Forms_Fields_GraduateStudy < Lib_Forms_Field

  attr_accessor :option
    
  def setOption(number)
    @option = number
    return self
  end
  
  def getSupportedValue
    if @option
      return @option
    else 
      return 'Education'
    end
  end

  def getUnsupportedValue
    return false
  end

  def validateText
    return 'Please insert valid values'
  end

  def setValue(tools, xpath, value)
    tools.watir_helper.reset.select_list(:xpath => xpath).select value
  end

  def self.getInstance
    unless @comboBox
      @comboBox = Lib_Forms_Fields_GraduateStudy.new
    end
    return @comboBox
  end

end