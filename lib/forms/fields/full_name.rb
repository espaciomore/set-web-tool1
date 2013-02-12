class Lib_Forms_Fields_FullName < Lib_Forms_Field

  def getSupportedValue
    return "Jhon Intellisys Test"
  end

  def getUnsupportedValue
    return ''
  end

  def setValue(tools, name, value)
    tools.watir_helper.reset.text_field(:id => name).type value
  end

  def validateText
    return 'Enter the name as it appears on this card'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_FullName.new
    end
    return @instance
  end
end