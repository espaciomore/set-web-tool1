class Lib_Forms_Fields_State < Lib_Forms_Fields_AutoComplete

  attr_accessor :state
    
  def setState (name)
    @state = name
    return self
  end
  
  def getSupportedValue
    if @state
      return @state
    else
      return 'New Jersey'
    end
  end

  def getUnsupportedValue
    return 'invalid'
  end

  def validateText
    return 'Please insert valid values'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_State.new
    end
    return @instance
  end

  def needsWaitTime
    return 2
  end
  
  def setValue(tools, name, value)
    _watirHelper = tools.watir_helper
    _watirHelper.reset.text_field(:name => name).typeBySet value
  end

end