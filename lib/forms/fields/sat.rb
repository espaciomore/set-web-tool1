class Lib_Forms_Fields_Sat < Lib_Forms_Fields_Text
  def getSupportedValue
    return 800
  end

  def getUnsupportedValue
    return 199
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_Sat.new
    end
    return @instance
  end
end