class Lib_Forms_Fields_DivButton < Lib_Forms_Field

  def getSupportedValue
    return false
  end

  def getUnsupportedValue
    return false
  end

  def validateText
    return 'Please insert valid values'
  end

  def self.getInstance
    unless @button
      @button = Lib_Forms_Fields_DivButton.new
    end
    return @button
  end

  def setValue(tools, selector, value)
    tools.browser.div(selector).click
  end
end