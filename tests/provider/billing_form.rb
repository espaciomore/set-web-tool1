module Tests_Provider_BillingForm
  def on_form2
    @watir_helper.reset.div( :xpath => '//*[@id="educateBillingContainer"]/div' )
  end
  
  def on_card_number
    on_form2.text_field( :id => 'cardNumber' )
  end

  def on_security_code
    on_form2.text_field( :id => 'securityCode' )
  end

  def on_card_holder
    on_form2.text_field( :id => 'nameOnCard' )
  end  

  def on_billing_address
    on_form2.text_field( :id => 'billingAddress' )
  end   
  
  def on_city_and_state
    on_form2.text_field( :id => 'cityAndState' )
  end

  def on_zipcode
    on_form2.text_field( :id => 'zipCode' )
  end   

  def on_company_phone
    on_form2.text_field( :id => 'companyPhone' )
  end   

  def on_now_create_button
    on_form2.link( :xpath => '//*[@id="noodleFormsButton"]/a[2]' )
  end    

  def on_back_button
    on_form2.link( :xpath => '//*[@id="noodleFormsButton"]/a[1]' )
  end  
end