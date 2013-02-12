class Lib_Forms_Fields_Subject < Lib_Forms_Fields_AutoComplete

  attr_accessor :subject
  @subject = 'SAT'
    
  def setSubject (name)
    @subject = name
    return self
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
      @instance = Lib_Forms_Fields_Subject.new
    end
    return @instance
  end

  def needsWaitTime
    return 2
  end

  def setValue(tools, name, value)
    tools.watir_helper.reset.text_field(:name => name).typeBySet value
  end
end