class Lib_Tools_LogInFactory < Lib_Tools_LogIn
  # credentials
  attr_accessor :user
  attr_accessor :pwd
  # context
  attr_accessor :main
  attr_accessor :context
  
  def login(params)
    @main = "#{params[:on]}"
    case params[:using]  
    when :test_user then 
      @user = params.has_key?(:user) ? params[:user]:Configuration::DEFAULT_USER
      @pwd = params.has_key?(:pwd) ? params[:pwd]:Configuration::DEFAULT_PASS
    when :facebook then
      @user = params.has_key?(:user) ? params[:user]:Configuration::FACEBOOK_USER
      @pwd = params.has_key?(:pwd) ? params[:pwd]:Configuration::FACEBOOK_PASS
    when :provider_user then
      @user = params.has_key?(:user) ? params[:user]:Configuration::PROVIDER_USER
      @pwd = params.has_key?(:pwd) ? params[:pwd]:Configuration::PROVIDER_PASS
    else
      @user = params.has_key?(:user) ? params[:user]:"noodle.test.#{params[:using].to_s}@gmail.com"
      @pwd = params.has_key?(:pwd) ? params[:pwd]:Configuration::DEFAULT_PASS    
      params[:using] = :test_user
    end 
    success = case params[:on]
    when :abstractHeader then 
      success = case params[:using]  
      when :facebook then 
        signIn.gigyaLink.withFacebook
      when :test_user then 
        signIn.withTestUser
      when :provider_user then
        signIn.withTestUser
      else
        false
      end
    when :contentWrapper
      success = case params[:using]  
      when :facebook then 
        centerWrapper.fbConnect.withFacebook      
      else
        false
      end   
    when :registrationStandalone
      success = case params[:using]  
      when :facebook then 
        signInHere.fbConnect.withFacebook  
      when :test_user then 
        signInHere.withTestUser
      when :provider_user then
        signInHere.withTestUser
      else
        false
      end 
    when :stepsHeader
      success = case params[:using]  
      when :facebook then 
        centerWrapper.fbConnect.withFacebook
      else
        false
      end     
    else
      false
    end
    $isLoggedIn = success
    return success
  end
  
  def onMain
    @watir_helper.reset.div(:xpath => '//*[@id="'+@main+'"]')
  end
    
  def onSignIn
    @watir_helper.reset.div(:xpath => '//*[@id="accountMenu"]')
  end
  
  def onSignInOverlay
    @watir_helper.reset.div(:xpath => '//*[@id="loginOverlayContainer"]')
  end
  
  def centerWrapper
    onMain
    self
  end
    
  def signIn
    if onMain.link( :xpath => '//*[@id="account"]/a' ).exists? 
      @watir_helper.click
    elsif onMain.span( :xpath => '//*[@id="account"]/span' ).exists? 
      @watir_helper.click
    end
    sleep 2
    onSignIn.style?('block')
    @context = :onSignIn
    self
  end

  def signInHere
    onMain.abutton(:text => 'Sign in here').click
    sleep 2
    onSignInOverlay.waitOnEval("style?('display: block;')")
    @context = :onSignInOverlay
    return self
  end
    
  def gigyaLink
    @watir_helper.div(:title => 'Facebook').click
    return self
  end
  
  def fbConnect
    @watir_helper.abutton(:href => '#facebook').click
    return self
  end
  
  def withFacebook    
    begin
      
      if @watir_helper.waitOnEval('has_window(1)',45) && @watir_helper.use_window(1)
        sleep 2
        if @watir_helper.waitOnEval('has_window(1)',15) && @watir_helper.reset.find(:id => 'email').exists?
          sleep 1
          @watir_helper.reset.text_field(:id => 'email').set @user
          sleep 1
          @watir_helper.reset.text_field(:id => 'pass').set @pwd
          sleep 1
          @browser.button(:name => 'login').click   
        end
      elsif @watir_helper.reset.find(:text => /Failed/).exists?
        puts "Failed connecting. Please try again later"
      end
      @watir_helper.waitOnEval('!has_window(1)',60)  
      @watir_helper.use_window(0)
      sleep 2  # => wait for redirect  
    rescue
      return false
    end      
    $user = @user
    
    return true
  end
  
  def withTestUser
    begin
      self.send(@context).text_field(:id => 'user').exists?
      self.send(@context).text_field(:id => 'user').type @user
      self.send(@context).span(:text => 'Sign in').click
      self.send(@context).text_field(:class => 'passwordLabel tk-ff-univers-bold').set @pwd
      sleep 1
      self.send(@context).text_field(:id => 'pass').set @pwd
      self.send(@context).span(:text => 'Sign in').click
      sleep 5
    rescue
      return false
    end
    $user = @user
    
    return true    
  end  
end