class Lib_Forms_Fields_CreditCardNumber < Lib_Forms_Field

  def getSupportedValue
    return "4242424242424242"
  end

  def getUnsupportedValue
    return "5242424242424242"
  end

  def setValue(tools, name, value)
    tools.watir_helper.reset.text_field(:id => name).type value
  end

  def validateText
    return 'Your card number is incorrect'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_CreditCardNumber.new
    end
    return @instance
  end
end