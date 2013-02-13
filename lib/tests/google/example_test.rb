class Tests_Google_ExampleTest < Libs_AcceptanceTest
  def test_report_path
    Config_Settings::REPORT_FOLDER_PATH  + "/google/google_homepage"
  end
  
  def test_logged_in
    false
  end
  
  def test_target_site
    "http://www.google.com"
  end
  
  def test_exec
    update_report("Test that the page is loading", page_loaded)
  end        
  
  private
  
  def page_loaded
    Proc.new do
      begin
        raise "verify page is loaded" if not @watir_helper.urlLike(test_target_site)
        success = true
      rescue Exception => e
        puts "FAILED to #{e}"
        success = false
      end
      success
    end
  end          
end
  