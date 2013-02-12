class Tests_Provider_RegistrationTest < Lib_Tests_AcceptanceTest
  # => https://stripe.com/docs/testing
  include Tests_Provider_AccountForm
  include Tests_Provider_BillingForm
  
  def getReportPath
    Config_Paths::REPORT_FOLDER_PATH + '/provider/provider_registration'
  end
  
  def testLoggedIn
    false
  end
  
  def testSite
    "#{$target_server}/educate"
  end
  
  def runTest
    update_report("[Provider Registration] Test that user can use click on Create an Account Now",
                  test_create_account_button)
    update_report("[Provider Registration] Test that user can see validation for registration account info form",
                  test_account_info_entries_validation)     
    update_report("[Provider Registration] Test that user go through billing info form",
                  test_account_info_entries)     
    update_report("[Provider Registration] Test that user can see validation for registration billing info form",
                  test_billing_info_entries_validation)                         
  end
  
  private 
  
  def test_create_account_button
    Proc.new do
      begin
        @watir_helper.reset.link(:xpath => '//*[@id="educateHeaderContainer"]/div/a').click
        raise "verify redirect to sign up page" if not @watir_helper.urlLike("/educate/sign-up")
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end
  
  def test_account_info_entries_validation
    Proc.new do
      begin
        on_company_name.type '#'
        on_first_name.type '#'
        on_last_name.type '#'
        on_email.type '#'
        on_password.type '#'
        on_verify_password.type '##'
        on_save_button.click
        sleep 2
        raise "verify first name validation" if not error_message_present(:firstNamefancyToolTip)
        raise "verify last name validation" if not error_message_present(:lastNamefancyToolTip)
        raise "verify email validation" if not error_message_present(:emailfancyToolTip)
        raise "verify password validation" if not error_message_present(:passwordfancyToolTip)
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end    
  end

  def test_account_info_entries
    Proc.new do
      begin
        on_company_name.type 'Noodle Test Provider'
        on_first_name.type 'Noodle Test'
        on_last_name.type 'Provider'
        on_email.type 'noodle.test.provider@gmail.com'
        on_password.type 'welc0me'
        #on_verify_password.type 'welc0me'
        on_save_button.click
        raise "verify redirect to billing info" if not @watir_helper.urlLike("/educate/billing?oid=")
        on_back_button.click
        raise "verify redirect to account info" if not @watir_helper.urlLike("/educate/sign-up?oid=")
        on_company_name.type 'Noodle Test Provider'
        on_save_button.click
        raise "verify redirect to billing info" if not @watir_helper.urlLike("/educate/billing?oid=")
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end    
  end  

  def test_billing_info_entries_validation
    Proc.new do
      begin
        on_card_number.type '40000000002'
        on_now_create_button.click
        #sleep 6
        #raise "verify card number validation" if not error_message_present(:cardNumberfancyToolTip)
        on_card_number.type '4000000000000002'
        on_security_code.type '99'
        on_now_create_button.click
        #sleep 6
        #raise "verify first name validation" if not error_message_present(:securityCodefancyToolTip)
        on_card_holder.type '#'
        on_billing_address.type '#'
        on_city_and_state.type '#'
        on_zipcode.type '#'
        on_company_phone.type '#'
        on_now_create_button.click
        sleep 2
        raise "verify first name validation" if not error_message_present(:companyPhonefancyToolTip)
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end    
  end
end

