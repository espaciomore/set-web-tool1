class Lib_Forms_Fields_DateNow < Lib_Forms_Field

  def getSupportedValue
    return Time.now.strftime("%B %d, %Y")
  end

  def getUnsupportedValue
    return ' '
  end

  def setValue(tools, name, value)
    _watirHelper = tools.watir_helper.reset
    _watirHelper.text_field(:name => name).type value
    tools.browser.div(:xpath,'//*[@id="noodleRecommendsQuestionnaire"]').click
  end

  def validateText
    return 'Please insert valid values'
  end

  def self.getInstance
    unless @instance
      @instance = Lib_Forms_Fields_DateNow.new
    end
    return @instance
  end
end