class Lib_Forms_Fields_AutoComplete < Lib_Forms_Field
  def setValue(tools, selector, value)
    _watirHelper = tools.watir_helper.reset
    _watirHelper.text_field(:xpath => selector).typeBySet value
    _watirHelper.reset.link(:text => value).click
  end
  
  def setExtraActions(tools, key, value)
    return false
  end
end