class Lib_Forms_Fields_GreAnalytical < Lib_Forms_Fields_Text
  def getSupportedValue
    return 6
  end

  def getUnsupportedValue
    return 7
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_GreAnalytical.new
    end
    return @instance
  end
end