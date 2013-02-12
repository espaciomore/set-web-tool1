class Tests_NeedRegistration_Users_FavoritesTest < Lib_Tests_AcceptanceTest

  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/users/favorites'
  end  

  def testLoggedOut
    return false
  end  
  
  def testSite
    "#{$target_server}/favorites"
  end
  
  def runTest     
    Config_Mappings::FAV_VERTICAL_URL.each do |vertical, href|
      update_report("[Favorites] Test that user can see favorites for #{vertical}",
                    test_favorites_link(vertical, href))     
    end               
  end   
  
  private
  
  def test_favorites_link(vertical, href)
    Proc.new do
      begin
        on_favorite_menu.link( :text => vertical ).click
        sleep 1
        on_favorite_menu.div( :xpath => "//*[@data-url='#{href}']" ).link( :text => "Favorites" ).click
        raise "verify redirect to /#{href}" if not @watir_helper.urlLike("#{testSite}/#{href}")
        raise "verify breadcrumb composition for #{vertical}" if not test_breadcrumbs(vertical)          
        # => verify results
        raise "verify favorites for #{vertical}" if not @watir_helper.reset.find(:xpath => '//*[@id="searchContent"]').divs(2).size >= 1
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end   
  end

  def test_breadcrumbs(verticalDisplay)
    begin
      raise "verify breadcrumb Home " if not @watir_helper.reset.find(:xpath => "//*[@id=\"pathBreadcrumb\"]/div[1]/a/span").text.include?("Home")
      raise "verify breadcrumb Home / Favorites" if not @watir_helper.reset.find(:xpath => "//*[@id=\"pathBreadcrumb\"]/div[2]/a/span").text.include?("Favorites")
      raise "verify breadcrumb Home / Favorites / #{verticalDisplay}" if not  @watir_helper.reset.find(:xpath => "//*[@id=\"pathBreadcrumb\"]/div[3]/span").text.include?(verticalDisplay)
      isValid = true
    rescue Exception => e
      puts "FAILED to #{e}"
      isValid = false
    end
    isValid
  end   
  
  def on_favorite_menu
    @watir_helper.reset.div( :xpath => '//*[@id="navigation"]/div' )
  end
  
end  