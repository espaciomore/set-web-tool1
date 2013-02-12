class Lib_Forms_Fields_Password < Lib_Forms_Field

  def getSupportedValue
    return Configuration::DEFAULT_PASS
  end

  def getUnsupportedValue
    return '123'
  end

  def setValue(tools, name, value)
    tools.watir_helper.reset.text_field(:id => name).type value
  end

  def validateText
    return 'Password not long enough'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_Password.new
    end
    return @instance
  end
end