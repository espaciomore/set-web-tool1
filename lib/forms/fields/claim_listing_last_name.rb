class Lib_Forms_Fields_ClaimListingLastName < Lib_Forms_Fields_Text

  def getSupportedValue
    return "Test I"
  end

  def getUnsupportedValue
    return ''
  end

  def validateText
    return 'Please enter your last name'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_ClaimListingLastName.new
    end
    return @instance
  end
end