module Tests_Provider_AccountForm
  def on_form
    @watir_helper.reset.div( :xpath => '//*[@id="educateSignUpContainer"]/div' )
  end
  
  def on_company_name
    on_form.text_field( :id => 'companyName' )
  end

  def on_first_name
    on_form.text_field( :id => 'firstName' )
  end  

  def on_last_name
    on_form.text_field( :id => 'lastName' )
  end   

  def on_email
    on_form.text_field( :id => 'email' )
  end  
   
  def on_password
    on_form.text_field( :id => 'password' )
  end  
   
  def on_verify_password
    on_form.text_field( :id => 'verifyPassword' )
  end  
  
  def on_save_button
    on_form.link( :xpath => '//*[@id="noodleFormsButton"]/a' )
  end 
  
  def error_message_present(_id)
    @watir_helper.reset.div( :id => _id.to_s ).attr(:class).include?('visible')
  end  
end