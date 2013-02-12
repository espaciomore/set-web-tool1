class Lib_Forms_Fields_GreQuantitative < Lib_Forms_Fields_Text

  def getSupportedValue
    return 800
  end

  def getUnsupportedValue
    return 199
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_GreQuantitative.new
    end
    return @instance
  end
end