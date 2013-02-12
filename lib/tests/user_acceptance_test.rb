class Lib_Tests_UserAcceptanceTest < Lib_Tests_AcceptanceTest
  
  def beforeSetUp
    super
    @dashboard = "#{$target_server}/home"
  end

  def getReportPath
    raise NotImplementedError
  end  
  
  def getFriendlyName
    return 'User Profile'
  end
  
  def canUseSearchButton
    begin
      @browser.a(:xpath, '//*[@id="startNewSearch"]').click
      sleep 2
      @generalTools.waitOrCrash('Select an icon below to start a new search.')
      @browser.a(:xpath, '//*[@id="periodicTable"]/tbody/tr[2]/td[1]/div/div/div[1]/a').click
      canOrCannot = @generalTools.waitUrl("#{$target_server}/k-12")
    rescue
      canOrCannot = false
    end
  end

   def changeProfilePhoto
    begin
      @browser.a(:xpath, '//*[@id="changeProfilePicture"]').click
      canOrCannot = @generalTools.waitOrCrash("Edit Profile Photo")
      @browser.a(:xpath, '//*[@id="cancelUpload"]').click
      canOrCannot
   rescue
      canOrCannot = false
    end
   end

  def gotoDashboard
    @browser.goto @dashboard
    @generalTools.waitUrl @dashboard
  end

  def gotoProfile
    @browser.goto" #{$target_server}/my-profile#"
    @generalTools.waitUrl  "#{$target_server}/my-profile#"
  end
  
  def editProfile    
    begin
      @browser.a(:xpath, '//*[@id="editProfileLink"]/a').click
      @generalTools.waitUrl "#{$target_server}/my-profile#"
    rescue
      #nothing
    end
  end
  
  def verifyList
    sleep(1)
    begin
      list = @browser.a(:text, 'test_list')
      return list.exists?
    rescue
      #nothing
    end
    return false
  end
  
  def deleteList
    begin
      @browser.span(:text, 'test_list').click
      @generalTools.waitOrCrash("Henry H. Filer Middle School")
      @browser.a(:xpath, '//*[@id="schoolsDetails"]/div[1]/div[5]/a').click
      @browser.a(:xpath, '//*[@id="deleteListOverlay"]/p[3]/a[1]').click
      return @generalTools.waitUrl("#{$target_server}/home")     
    rescue
      #nothing
    end  
    return false
  end
  
  def createList name
    begin
      sleep(1)
      @browser.a(:text, 'Create list').click
      @browser.text_field(:name, 'createList').set name
      @browser.select_list(:name, 'privacySettingsForNewList').select 'Everyone'
      @browser.a(:xpath, '//*[@id="createListOverlay"]/p[4]/a[1]').click
      sleep(1)
      @browser.goto("#{$target_server}/k-12/fl/hialeah/henry-h-filer-middle-school#overview")
      @generalTools.waitUrl("#{$target_server}/k-12/fl/hialeah/henry-h-filer-middle-school#overview")
      @browser.a(:xpath, '//*[@id="profileHeader"]/div[3]/div/a').click
      @browser.select_list(:xpath, '//*[@id="addToListOverlay"]/p[2]/select').select name
      @browser.a(:xpath, '//*[@id="addToList"]').click    
      sleep(1)    
    rescue
      #nothing
    end
  end
  
  def removeFriend
    begin
      @browser.a(:href, "#{$target_server}/profile/1032").click
      @generalTools.waitUrl "#{$target_server}/profile/1032#"
      if not @generalTools.verifyText "Emilio Santelises" 
        return false
      end
      @browser.a(:id, "removeAsAFriend").click
      sleep(1)
      #@browser.a(:xpath, '//*[@id="removeFriendOverlay"]/div[2]/div/p/a[2]').click
      @browser.a(:xpath, '//*[@id="removeFriendOverlay"]/div[2]/div/p/a[1]').click
      friendRemoved = true
    rescue
      friendRemoved = false
    end
    return friendRemoved
  end
  
  def addFriend
    begin
      @browser.goto "#{$target_server}/profile/1034"
      @generalTools.waitUrl "#{$target_server}/profile/1034#"
      if not @generalTools.verifyText "Emilio Molina" 
        return false
      end
      @browser.a(:id, "addAsAfriend").click
      sleep(1)
      #@browser.a(:xpath, '//*[@id="addFriendOverlay"]/div[2]/div/p/a[2]').click
      #let's mock it, because it sends an email first and then wait for confirmation
      @browser.a(:xpath, '//*[@id="addFriendOverlay"]/div[2]/div/p/a[1]').click
      friendAdded = true
    rescue
      friendAdded = false
    end
    return friendAdded
  end
  
  def verifyFriend
    begin
      friend = @browser.a(:href, "#{$target_server}/profile/1032")
      return friend.exists?
    rescue 
      #nothing
    end
    return false
  end
end