class Lib_Forms_Fields_GreVerbal < Lib_Forms_Fields_Text

  def getSupportedValue
    return 170
  end

  def getUnsupportedValue
    return 129
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_GreVerbal.new
    end
    return @instance
  end

end