class Tests_About_AboutNoodleTest < Lib_Tests_AcceptanceTest

  def getReportPath
    Config_Paths::REPORT_FOLDER_PATH + '/about/about_noodle'
  end
  
  def testLoggedIn
    false
  end
  
  def testSite
    "#{$target_server}/about_noodle"
  end
  
  def runTest
    update_report("[About Noodle] Test that user can see about noodle page",
                  test_about_noodle)
    update_report("[About Noodle] Test that user can see what we do page",
                  test_what_we_do)
    update_report("[About Noodle] Test that user can see team page",
                  test_team)
    update_report("[About Noodle] Test that user can see press page",
                  test_press)     
    update_report("[About Noodle] Test that user can see careers page",
                  test_careers)       
    update_report("[About Noodle] Test that user can see contact page",
                  test_contact)       
    update_report("[About Noodle] Test that user can see privacy policy page",
                  test_privacy_policy)        
    update_report("[About Noodle] Test that user can see terms of service page",
                  test_terms_of_service)            
    update_report("[About Noodle] Test that user can see provider terms of service page",
                  test_provider_terms_of_service) 
  end  
  
  def test_about_noodle
    Proc.new do
      begin 
        raise "verify about noodle content title" if not on_center.find( :text => /About Noodle/).exists?
        isValid = true 
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end

  def test_what_we_do
    Proc.new do
      begin
        on_sidebar.link( :text => /What We Do/ ).click
        raise "verify redirect to /what_we_do" if not @watir_helper.urlLike("/what_we_do")        
        raise "verify what we do content title" if not on_center.find( :text => /Find the Right Education with Noodle./).exists?
        isValid = true 
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end

  def test_team
    Proc.new do
      begin
        on_sidebar.link( :text => /Team/ ).click
        raise "verify redirect to /team" if not @watir_helper.urlLike("/team")        
        raise "verify team content title" if not on_center.find( :text => /The Noodle Team/).exists?
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end

  def test_press
    Proc.new do
      begin
        on_sidebar.link( :text => /Press/ ).click
        raise "verify redirect to /press" if not @watir_helper.urlLike("/press")        
        raise "verify press content title" if not on_center.find( :text => /Press Releases/).exists?
        isValid = true 
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end

  def test_careers
    Proc.new do
      begin
        on_sidebar.link( :text => /Careers/ ).click
        raise "verify redirect to /careers" if not @watir_helper.urlLike("/careers")        
        raise "verify careers content title" if not on_center.find( :text => /Why Work at Noodle?/).exists?
        isValid = true 
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end
  
  def test_contact
    Proc.new do
      begin
        on_sidebar.link( :text => /Contact/ ).click
        raise "verify redirect to /contact" if not @watir_helper.urlLike("/contact")        
        raise "verify contact content title" if not on_center.find( :text => /Have a question?/).exists?
        isValid = true 
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end

  def test_privacy_policy
    Proc.new do
      begin
        on_sidebar.link( :text => /Privacy Policy/ ).click
        raise "verify redirect to /privacy-policy" if not @watir_helper.urlLike("/privacy-policy")        
        raise "verify privacy-policy content title" if not on_center.find( :text => /Your Personal Information on Noodle/).exists?
        isValid = true 
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end

  def test_terms_of_service
    Proc.new do
      begin
        on_sidebar.link( :text => 'Terms of Service' ).click
        raise "verify redirect to /terms-of-service" if not @watir_helper.urlLike("/terms-of-service")        
        raise "verify terms of service content title" if not on_center.find( :text => 'Terms of Service').exists?
        isValid = true 
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end

  def test_provider_terms_of_service
    Proc.new do
      begin
        on_sidebar.link( :text => /Provider Terms of Service/ ).click
        raise "verify redirect to /provider-terms-of-service" if not @watir_helper.urlLike("/provider-terms-of-service")        
        raise "verify provider-terms-of-service content title" if not on_center.find( :text => /Tutor Client Terms of Service/ ).exists?
        isValid = true 
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end
              
  def on_sidebar
    @watir_helper.reset.div( :id => 'sidebar-left' )
  end
    
  def on_center
    @watir_helper.reset.div( :id => 'center' )
  end
end