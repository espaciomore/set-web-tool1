class Tests_Provider_ProfilePage < Lib_Tools_ProfileSpecification
  def testBreadcrumb comp=nil
    return @generalTools.testBreadcrum(comp)
  end
  
  def testProfileImage
    _image = onProfileHeader.image(:xpath => 'div[1]/div/img')
    return _image.exists? ? _image.loaded? : false
  end
  
  def testHeaderTitle text=''
    _title = onProfileHeader.h1(:xpath => 'div[2]/div/div[1]/h1')
    return _title.exists? ? _title.getText.include?(text) : false
  end
  
  def onProfileHeader
    return @watir_helper.reset.div(:xpath => '//*[@id="profileHeader"]')
  end  
end