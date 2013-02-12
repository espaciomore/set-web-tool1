class Lib_Forms_Fields_Location < Lib_Forms_Fields_AutoComplete
  
  attr_accessor :location
    
  def setLocation (location)
    @location = location
    return self
  end
  
  def getSupportedValue
    if @location
      return @location
    else
      return 'Alicante, Spain'
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
      @instance = Lib_Forms_Fields_Location.new
    end
    return @instance
  end
end