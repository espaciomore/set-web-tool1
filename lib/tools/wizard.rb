class Lib_Tools_Wizard 
  
  def initialize(tools)
    @browser = tools.browser
    @generalTools = tools  
    @watir_helper = tools.watir_helper
  end
  
  def submit()
    @generalTools.waitOrCrash("mButton submit wizard-submit",3)
    begin
      @browser.link(:class, "mButton submit wizard-submit").click
    rescue
      puts :CouldNotSubmit
    end  
  end

# The saveResults method is used to save the results of Production for a later comparison
#  def saveResults(wizard)
#    if $saveResults and $target_server == Constants::PROD
#      html = Hpricot(@browser.html)
#
#      results = Array.new
#
#      html.search("h3").each do |list|
#        results << list.inner_text.strip
#      end
#
#      filePath = Config_Paths::SAVE_RESULTS_PATH + "/results_"+wizard+"_prod"
#
#      if(createDirectory(filePath))
#        strFile = File.open(filePath, 'w')
#      else
#        print 'false'
#        return false
#      end
#      strFile.puts(results)
#      strFile.close
#      puts 'true'
#      return true
#    end
#  end

  def validateSingleClick(formfield)
    formfield.each do |key, value|
      puts key
      puts value
    end
  end

  def verifyResults (timeout=Configuration::WAIT_TIMEOUT)
    gridViewItems = nil
    for i in 0..(timeout*2)
      sleep(0.5)
      gridViewItems = @watir_helper.reset.find({:xpath => '//*[@id="searchContent"]/div[1]'},0.5).exists?
      if gridViewItems
        return true
      end
    end
    
    return false
  end

  def matchResults(wizard, source)
    begin
      html = Hpricot(source)
  
      results = Array.new
      results2 = Array.new
      results3 = Array.new
  
      html.search("h3").each do |list|
        results << list.inner_text.strip
      end
  
      strFile = File.open($resultsPath+"tempResults", 'w')
      strFile.puts(results)
      strFile.close
  
      i=0
  
      IO.foreach $resultsPath+"results"+wizard+"Prod" do |line|
        results2 << line
      end
  
      IO.foreach $resultsPath+"tempResults" do |line|
        results3 << line
      end
  
      match = 0
      nomatch = 0
  
      for i in 0..13 do
        if results2[i] == results3[i]
          match += 1
        else
          nomatch += 1
        end
        # puts results2[i]
        # puts results3[i]
        i += 1
      end
  
      if nomatch > 0
        return false
      else
        return true
      end
  
      File.delete($resultsPath+"tempResults")
    rescue
      puts :ErrorWhileSavingMatchResults
    end
  end

  def nextQuestion(wait_time=0.75)
    begin
      @browser.link(:class, "next").click
      sleep wait_time
    rescue
      puts :CouldNotGoToNextQuestion
    end
  end

  def prevQuestion(wait_time=0.75)
    begin  
      @browser.link(:class, "prev").click
      sleep wait_time
    rescue
      puts :CouldNotGoToPreviousQuestion
    end
  end

  def testValidation(values, i=0)
    catch :loop do
      values.each do |field, value|
        throw :loop if value.length <= i
        @browser.text_field(:name => field).set value[i]
      end
      sleep 2
      submit()
      if verifyText("Please insert valid values") == true
        sleep 2
        testValidation(values, i+=1)
      else
        prevQuestion()
        sleep 3
      end
    end
  end

  def startOver
    if $isLoggedIn
      begin
        @watir_helper.reset.find( :class => "editPreferenceContainer").waitOnEval("style?('block')")
        @watir_helper.reset.link(:class => 'tk-ff-univers-bold editPreferences').click
        sleep 2
        @watir_helper.reset.find( :class => "editPreferenceContainer").waitOnEval("style?('block')")
        @watir_helper.reset.link(:text => 'Clear preferences and start over').click
        sleep 2
        @watir_helper.reset.find( :class => "editPreferenceContainer").waitOnEval("style?('block')")
      rescue
        #nothing
      end
    end
  end
  
  def waitForQuestion selector
     _exit = @watir_helper.reset.find(selector,10).exists?
     sleep 1
     _exit
  end
end