class Lib_Forms_Fields_CreditCardSecurityCode < Lib_Forms_Field

  def getSupportedValue
    return "000"
  end

  def getUnsupportedValue
    return "-1"
  end

  def setValue(tools, name, value)
    tools.watir_helper.reset.text_field(:id => name).type value
  end

  def validateText
    return "Your card's security code is invalid"
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_CreditCardSecurityCode.new
    end
    return @instance
  end
end