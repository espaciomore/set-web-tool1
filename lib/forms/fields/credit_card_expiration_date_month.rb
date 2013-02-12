class Lib_Forms_Fields_CreditCardExpirationDateMonth < Lib_Forms_Fields_Selects

  attr_accessor :option
    
  def setOption (number)
    @option = number
    return self
  end
  
  def getSupportedValue
      return Time.now.month
  end

  def getUnsupportedValue
    return 1
  end

  def validateText
    return "Your card's expiration month is invalid"
  end

  def self.getInstance
    unless @comboBox
      @comboBox = Lib_Forms_Fields_CreditCardExpirationDateMonth.new
    end
    return @comboBox
  end

end