class Lib_Forms_Fields_Selects < Lib_Forms_Field
  def setValue(tools, xpath, value)
    _watirHelper = tools.watir_helper.reset
    options = _watirHelper.select_list(:xpath => xpath).options    
    _watirHelper.select options[value].text
  end
end