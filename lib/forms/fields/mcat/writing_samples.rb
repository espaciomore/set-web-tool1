class Lib_Forms_Fields_Mcat_WritingSamples < Lib_Forms_Fields_Text

  def getSupportedValue
    return 'l'
  end

  def getUnsupportedValue
    return 0
  end

  def validateText
    return 'Please insert valid values'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_Mcat_WritingSamples.new
    end
    return @instance
  end
end