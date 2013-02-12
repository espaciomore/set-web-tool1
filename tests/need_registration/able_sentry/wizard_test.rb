class Tests_NeedRegistration_AbleSentry_WizardTest < Lib_Tests_AcceptanceTest
  def testWizard
    update_report("[Able Sentry Project] Test that the user can see the welcome message then go pass it",
                  test_welcome_message)                            
    update_report("[Able Sentry Project] Test that the user can go through the wizard following the right question flow with pauses and rewards",
                  test_able_sentry_wizard)
    update_report("[Able Sentry Project] Test that the user is redirected to the dashboard where user will see the results",
                  test_redirect)   
  end
  
  private  
  
  def test_welcome_message
    Proc.new do
      begin
        sleep 2
        raise "verify welcome message not present" if @watir_helper.reset.h1( :text => 'Welcome to Noodle!' ).exists?
        #startWizardContainer.span(:text => 'Start Now').click
        isValid = true
      rescue Exception => e 
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end
  
  def test_able_sentry_wizard
    Proc.new do
      begin      
        _answered = 1
        getStreaks.each do |streak|
          streak[:streak].each do |question|
            onPanel question[:index]
            raise "verify wizard flow is right on question: \"#{question[:title]}\"" if !(getTitle.include?(question[:title]) && (answered==_answered) && isChoiceImgLoading)
            getChoice.click    
            _answered += 1    
          end   
        end
        isValid = true
      rescue Exception => e 
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end

  def test_redirect
    Proc.new do
      begin
        raise "verify redirect to dashboard" if not @watir_helper.urlLike("#{$target_server}/home")
        isValid = true
      rescue Exception => e 
        puts "FAILED to #{e}"
        isValid = false
      end
      isValid
    end
  end
    
  def getStreaks
   return [{:streak => [{:title=>"When you want to learn something new, you:",:index=>32},
                     {:title=>"Will you be searching on behalf of:",:index=>33},
                     {:title=>"Which best describes you?",:index=>34},
                     {:title=>"Of these, which do you most enjoy?",:index=>36},
                     ],
           :index => 0},
           ]
  end  
  
  def onWizard(wPath='//*[@id="wizardContainer"]')
    return @watir_helper.reset.div(:xpath => wPath)  
  end
  
  def onPanel(_index=0)
    if _index>0
      @panel = onWizard.li(:xpath => "//*[@id=\"qid_#{_index}\"]")
    end
    return @panel
  end
  
  def getTitle
    return onPanel.h1(:xpath => "div/h1").text
  end
  
  def getChoice(_index=1)
    return onPanel.li(:xpath => "ul/li[#{_index}]")
  end
  
  def isChoiceImgLoading(ipath='div/div/img')
    return getChoice.image(:xpath => ipath).loaded?
  end
  
  def answered(lPath='//*[@id="wizardContainer"]/div/div[1]/ul')
    return onWizard.ul(:xpath => lPath).lis(6).size
  end
  
  def unAnswered(lPath='//*[@id="wizardContainer"]/div/div[2]/ul')
    return onWizard.ul(:xpath => lPath).lis(6).size
  end
  
  def delay dTime=3
    @generalTools.wait('youwontfindthis',3)
  end
end