class Tests_Modules_HeaderTest < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/modules/header_module'
  end

  def testLoggedOut
    return false
  end

  def testSite
    return "#{$target_server}/"
  end

  def runTest
    update_report("[Header Module] Test that user can see noodle logo",
                  test_noodle_logo)
    update_report("[Header Module] Test that user can see Home options are displaying",
                  test_home_menu)                  
    update_report("[Header Module] Test that user can see Username options are displaying",
                  test_user_menu)
  end

  private

  def test_noodle_logo
    Proc.new do
      begin
        _image = onHeader.image(:xpath => 'div[2]/div/div[1]/a/img')
        raise "verify logo image loaded" if not _image.loaded?
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end
      _isValid
    end
  end
  
  def test_home_menu
    Proc.new do
      begin
        _items = Config_Mappings::VERTICAL_URL
        _items["Home"] = nil
        #_items["Manage Your Listings"] = nil
        onThisMenu.span(:xpath => 'div[1]/span').hover
        sleep 2
        onThisMenu.ul(:xpath => 'div[1]/div[2]/ul').lis(12).each do |item|
          _itemValue = @watir_helper.setElement(item).spans( :xpath => 'div/a//span').last.text
          raise "verify home menu item: #{_itemValue}" if not _items.has_key?(_itemValue)
        end
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end  
      _isValid
    end
  end

  def test_user_menu
    Proc.new do
      begin
        _items = { 'Profile'=>nil,'Settings'=>nil,'Logout'=>nil }
        onThisMenu.span(:xpath => 'div[2]/span').hover
        sleep 2
        _isValid = true
        onThisMenu.ul(:xpath => 'div[2]/div[2]/ul').lis(3).each do |item|
          _itemValue = @watir_helper.setElement(item).spans( :xpath => 'div/a//span').last.text
          raise "verify user menu item: #{_itemValue}" if not _items.has_key?(_itemValue)
        end
        _isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        _isValid = false
      end        
      _isValid
    end
  end
    
  def onHeader
    return @watir_helper.reset.div(:id => 'abstractHeader')
  end

  def onThisMenu
    return onHeader.div(:class => 'abstractHeaderMenu')
  end
end