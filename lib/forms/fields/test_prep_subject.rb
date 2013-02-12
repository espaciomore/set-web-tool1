class Lib_Forms_Fields_TestPrepSubject < Lib_Forms_Fields_Subject

  attr_accessor :subject
    
  def setSubject (name)
    @subject = name
    return self
  end
  
  def getSupportedValue
    if @subject
      return @subject
    else
      return 'SAT'
    end
  end
  
  def getSupportedValue
    return @subject
  end

  def getUnsupportedValue
    return 'invalid'
  end

  def validateText
    return 'Please insert valid values'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_TestPrepSubject.new
    end
    return @instance
  end
  
  def setValue(tools, name, value)
    tools.watir_helper.reset.text_field(:name => name).typeBySet value
  end
end