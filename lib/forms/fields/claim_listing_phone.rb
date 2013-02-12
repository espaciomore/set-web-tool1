class Lib_Forms_Fields_ClaimListingPhone < Lib_Forms_Field

  def getSupportedValue
    return "7357357357"
  end

  def getUnsupportedValue
    return ''
  end

  def setValue(tools, name, value)
    tools.watir_helper.reset.text_field(:id => name).type value
  end

  def validateText
    return 'Please enter a valid phone'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_ClaimListingPhone.new
    end
    return @instance
  end
end