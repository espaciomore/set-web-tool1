class Lib_Forms_Fields_Email< Lib_Forms_Field

  def getSupportedValue
    return Configuration::DEFAULT_USER
  end

  def getUnsupportedValue
    return "noodle@123"
  end

  def validateText
    return 'Please enter a valid email address'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_Email.new
    end
    return @instance
  end

  def setValue(tools, xpath, value)
    tools.watir_helper.reset.text_field(:xpath => xpath).type value
  end
end