class Lib_Tools_GeneralSite < Lib_Tool
  def clickTab(tabName)
    @watir_helper.reset.abutton(:href => "##{tabName}").clickOn
  end

  def setValues(values)
    values.each do |field, value|
      @watir_helper.reset.text_field(:name => field).set value
    end
  end

end