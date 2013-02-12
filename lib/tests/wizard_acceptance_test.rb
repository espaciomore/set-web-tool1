class Lib_Tests_WizardAcceptanceTest < Lib_Tests_AcceptanceTest
  
  def testLoggedIn
    (!$runnungThread or !$thread)
  end
  
  def testLoggedOut
    false # => ($runnungThread or !$thread)
  end
  
  def getReportPath
    Config_Paths::WIZARD_REPORT_FOLDER_PATH + '/' + self::getWizardName + '/' + self::getWizardName
  end

  def getWizardName
    raise NotImplementedError
  end
  
  def beforeTearDown
    super
    self::saveResults
    self::compareResults
    if not $isLoggedIn
      testSaveMyResults(self::getFriendlyName)
    end
  end

  def saveResults()
    if $saveResults and ($target_server == Constants::PROD)
      begin
        html = Hpricot(@browser.html)
        results = Array.new
        html.search("h3").each do |list|
          results << list.inner_text.strip
        end
        filePath = Config_Paths::SAVE_RESULTS_PATH + '/' + self::class.name
        if(createDirectory(filePath))
          strFile = File.open(filePath, 'w')
        else
          return false
        end
        strFile.puts(results)
        strFile.close
        return true
      rescue
        #just break
      end
    end
    return false
  end

  def compareResults()
    testName = self::getFriendlyName
    
    if File.exists?(Config_Paths::SAVE_RESULTS_PATH + '/' + self::class.name)
      begin
        html = Hpricot(@browser.html)
  
        results = Array.new
        prodResults = Array.new
        tempResults = Array.new
  
        html.search("h3").each do |list|
          results << list.inner_text.strip
        end
  
        filePath = Config_Paths::SAVE_RESULTS_PATH + '/' + self::class.name + 'temp'
  
        if(createDirectory(filePath))
          strFile = File.open(filePath, 'w')
        else
          return false
        end
  
        strFile.puts(results)
        strFile.close
  
        IO.foreach Config_Paths::SAVE_RESULTS_PATH+'/'+self::class.name do |line|
          prodResults << line
        end
  
        IO.foreach Config_Paths::SAVE_RESULTS_PATH+'/'+self::class.name+'temp' do |line|
          tempResults << line
        end
  
        nomatch = 0
  
        for i in 0..prodResults.size do
          if (!(prodResults[i] == tempResults[i]))
            nomatch += 1
          end
        end
  
        if nomatch == 0
          matchResult = 'match'
        else
          matchResult = 'nomatch'
        end
      rescue
        matchResult = 'CRASHED'
      end
      update_report('['+ testName +'] Matching results with production', (@report.overallResult=='PASSED' ? matchResult : 'CRASHED'))
    else
      update_report('['+ testName +'] There are no results to compare with', (@report.overallResult=='PASSED' ? 'nomatch' : 'CRASHED'))
    end
  end
  
  def getFriendlyName
    wizardReportName = self::getWizardName
    wizardReportName = wizardReportName.split('_').each {|w| w.capitalize! }
    wizardReportName.join(' ')
  end
  
  def saveMyResults 
    'Save My Results'
  end
  
  def testSaveMyResults(testName)
    begin
      @browser.span(:text => saveMyResults).click
      sleep(2)
      overlay = @watir_helper.reset.find(:xpath => '//*[@class="blockUI blockMsg blockPage"]/div').style? 'block'
    rescue
      overlay = false    
    end
    update_report("[#{testName}][seward] Test that after user completes wizard, user can click on 'Save my results'",
                        (@report.overallResult=='PASSED' ? overlay : 'CRASHED'))
  end
  
  def register(testName, xname, xemail, xpwd)
    super
  end
  
  def testOptions(options, question, instance)
    testName = getFriendlyName
    limit = options.size - 1 
    step = 0
    isValid = true
    errors = []
    if (@report.overallResult=='PASSED')
      options.each do |option|
        begin
          @wizardTools.waitForQuestion(:text => "#{question}")
          result = @validator.validate([{"#{option["choice"]}" => instance}])
          if option["hasResults"]
             result = (result and @wizardTools.verifyResults())
          end
          isValid = (result and isValid)
          if isValid
            errors << "#{option["choice"]}"
          end
          if step < limit
            @wizardTools.prevQuestion()
          end
          step += 1
        rescue
          isValid = false
          break
        end
      end    
    end
    if isValid
      update_report('['+testName+"] Validating: \"#{question}\"", (@report.overallResult=='PASSED' ? true : 'CRASHED'))
    else
      update_report('['+testName+"] Validating: \"#{question}\" missed [#{errors.join(' , ')}]", (@report.overallResult=='PASSED' ? false : 'CRASHED'))
    end
  end
  
  def testCheckButtons(options, currQuestion, nextQuestion)
    if (@report.overallResult=='PASSED')
      result = true
      options.each do |option|
        begin
          @watir_helper.reset.find(option[:selector] => option[:value]).click
          @wizardTools.waitForQuestion(:text => nextQuestion)
          if option[:hasResults]
            result = (result && hasResults?)
          end
          if not option[:last]
            @wizardTools.prevQuestion
            @wizardTools.waitForQuestion(:text => currQuestion)
          end
        rescue
          result = false
          break
        end
      end
    else
      result = 'CRASHED'
    end
    update_report("[#{getFriendlyName}] Testing validation for \"#{currQuestion}\"", result)
  end
  
  def clearAll
    begin
      @watir_helper.reset.find(:xpath => '//div[@class="quickPanelTopButtomContainer"]/a[1]').click
      sleep 2
    rescue
      #nothing
      puts :CouldNotClearPanel
    end 
  end
  
  def hasResults? timeout=10
    #sleep 1
    return @wizardTools.verifyResults(timeout)
  end

  def testGVI test_class
    @_GVI = test_class.new( @generalTools )
    @_GVI.onGVI( @watir_helper.reset.find( :xpath => '//*[@id="searchContent"]/div[1]' ).element )
    @generalTools.setGVI @_GVI
    @generalTools.testGridItem( getFriendlyName )       
  end  
end