class Lib_Forms_Fields_HighSchool < Lib_Forms_Fields_AutoComplete

  attr_accessor :highschool
    
  def setHighschool (name)
    @highschool = name
    return self
  end
  
  def getSupportedValue
    if @highschool
      return @highschool
    else
      return 'German School New York - White Plains, NY'
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
      @instance = Lib_Forms_Fields_HighSchool.new
    end
    return @instance
  end

  def setValue(tools, xpath, value)
    _watirHelper = tools.watir_helper.reset
    _watirHelper.text_field(:xpath => xpath).type value
  end
end