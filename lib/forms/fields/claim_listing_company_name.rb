class Lib_Forms_Fields_ClaimListingCompanyName < Lib_Forms_Field

  def getSupportedValue
    return "Test Prep New York"
  end

  def getUnsupportedValue
    return ''
  end

  def setValue(tools, name, value)
    tools.watir_helper.reset.text_field(:id => name).type value
  end

  def validateText
    return 'Please provide a valid company'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_ClaimListingCompanyName.new
    end
    return @instance
  end
end