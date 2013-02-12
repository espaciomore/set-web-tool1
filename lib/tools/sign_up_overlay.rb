class Lib_Tools_SignUpOverlay < Lib_Tools_Registration
  def validate_entries_for_new_user
    begin
      on_signup_button.click
      raise "verify name entry validation" if not on_overlay.div( :id => 'errSignupName' ).attr('class').include?('_visible')
      raise "verify email entry validation" if not on_overlay.div( :id => 'errSignupEmail' ).attr('class').include?('_visible') 
      raise "verify password entry validation" if not on_overlay.div( :id => 'errSignupPass' ).attr('class').include?('_visible')
      raise "verify birthdate entry validation" if not on_overlay.div( :id => 'errAge' ).attr('class').include?('_visible') 
      raise "verify terms of service entry validation" if not on_overlay.div( :id => 'agreetErr' ).attr('class').include?('_visible')  
      _exit = true   
    rescue Exception => e
      puts "FAILED to #{e}"
      _exit = false   
    end
    _exit
  end

  def validate_facebook_agreement
    begin
      on_name_entry.type @registeredName
      on_email_entry.type @registeredEmail
      on_password_entry.type @registeredPassword
      on_birth_month_entry.select @registeredBirthMonth
      on_birth_day_entry.select @registeredBirthDay
      on_birth_year_entry.select '1989'
      on_fb_button.click
      sleep 0.5
      raise "verify sign-up with facebook validation" if not on_overlay.div( :id => 'agreetErr' ).attr('class').include?('_visible')  
      _exit = true   
    rescue Exception => e
      puts "FAILED to #{e}"
      _exit = false   
    end
    _exit
  end

  def validate_birthdate_for_new_user
    begin     
      on_birth_year_entry.select '2002'
      on_terms_of_service.set   
      on_signup_button.click   
      sleep 2
      raise "validate age greater than 13 years old" if not on_overlay.p( :text => /Sorry we are not able to process your registration./ ).exists?
      on_overlay.link( :text => /Close/ ).click
      sleep 2
      _exit = true   
    rescue Exception => e
      puts "FAILED to #{e}"
      _exit = false   
    end
    _exit
  end

  def register_new_user
    begin     
      on_name_entry.type @registeredName
      on_email_entry.type @registeredEmail
      on_password_entry.type @registeredPassword
      on_birth_month_entry.select @registeredBirthMonth
      on_birth_day_entry.select @registeredBirthDay
      on_birth_year_entry.select @registeredBirthYear
      on_terms_of_service.set   
      on_signup_button.click   
      raise "verify user registration" if not @watir_helper.urlLike("#{$target_server}/home")
      _exit = true   
    rescue Exception => e
      puts "FAILED to #{e}"
      _exit = false   
    end
    _exit
  end   
   
  def get_overlay_on_homepage
    begin
      @watir_helper.reset.link( :text => /Sign Up/ ).click
      sleep 2
      raise "verify sign up overlay" if not on_overlay.style?('block')
      _exit = true
    rescue Exception => e
      puts "FAILED to #{e}"
      _exit = false   
    end
    _exit
  end
  
  private 
  
  def on_overlay
    @watir_helper.reset.div( :id => 'signUpOverlayContainer' )
  end
  
  def on_name_entry
    on_overlay.text_field( :id => 'name')
  end
  
  def on_email_entry
    on_overlay.text_field( :id => 'user')
  end

  def on_password_entry
    on_overlay.text_field( :id => 'pass')
  end  
  
  def on_birthday
    on_overlay.div( :id => 'dateOfBirth' )
  end
  
  def on_birth_month_entry
    on_birthday.select_list( :id => 'birthMonth' )
  end
  
  def on_birth_day_entry
    on_birthday.select_list( :id => 'birthDay' )
  end  
  
  def on_birth_year_entry
    on_birthday.select_list( :id => 'birthYear' )
  end 
  
  def on_terms_of_service
    on_overlay.checkbox( :id => 'agreed' )
  end 
  
  def on_signup_button
    on_overlay.link( :href => "#registration" )
  end 

  def on_fb_button
    on_overlay.link( :xpath => '//*[@id="ableSentrySignUpOverlayContainer"]/form/div/div[1]/a' )
  end   
end