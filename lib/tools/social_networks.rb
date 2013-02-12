class Lib_Tools_SocialNetworks 
  def initialize(tools)
    @watir_helper = tools.watir_helper
    @generalTools = tools
  end
  
  def testSocialNetwork target
    return self.send(target)  
  end
  
  private
  def askAFriend()
    begin
      title = shareButton.title
      hasButton = true
    rescue
      hasButton = false
    end
    begin
      shareButton.click
      @generalTools.waitOrCrash('Share with your friends')
      @watir_helper.reset.find(:xpath => '/html/body/div/table/tbody/tr[2]/td[2]/div/div/table[4]/tbody/tr[2]/td/table/tbody/tr[2]/td/table/tbody/tr/td[2]/div')
      hasOverlay = title.include?(@watir_helper.text)
    rescue
      hasOverlay = false
    end
    return (hasButton && hasOverlay)
  end
  
  def shareButton()
    return @watir_helper.reset.abutton(:class => ' askAFriend')
  end
end