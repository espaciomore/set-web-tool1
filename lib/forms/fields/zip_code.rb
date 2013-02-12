class Lib_Forms_Fields_ZipCode < Lib_Forms_Fields_AutoComplete

  attr_accessor :zipCode
    
  def setZipCode (zipcode)
    @zipCode = zipcode
    return self
  end
  
  def getSupportedValue
    if @zipCode
      return @zipCode
    else
      return '33166'
    end
  end

  def getUnsupportedValue
    "00000"
  end

  def validateText
    'Please insert valid values'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_ZipCode.new
    end
    @instance
  end

  def setValue(tools, selector, value)
    _watirHelper = tools.watir_helper.reset.text_field(:name => selector).typeBySet value  
  end  
end