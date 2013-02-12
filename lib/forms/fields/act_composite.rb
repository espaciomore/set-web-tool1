class Lib_Forms_Fields_ActComposite < Lib_Forms_Fields_Text
  def getSupportedValue
    return 36
  end

  def getUnsupportedValue
    return 100
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_ActComposite.new
    end
    return @instance
  end
end