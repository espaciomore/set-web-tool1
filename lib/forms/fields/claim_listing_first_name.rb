class Lib_Forms_Fields_ClaimListingFirstName < Lib_Forms_Field

  def getSupportedValue
    return "Jhon S"
  end

  def getUnsupportedValue
    return ''
  end

  def setValue(tools, name, value)
    tools.watir_helper.reset.text_field(:id => name).type value
  end

  def validateText
    return 'Please enter your first name'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_ClaimListingFirstName.new
    end
    return @instance
  end
end