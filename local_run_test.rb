class LocalRunTest
  def initialize()
    defineScopeVariable()
    defineGlobalVariables()
    setUpOptions()
  end

  def runTests()
    initReport()
    #!
    if @_tests.empty?
      @_tests << Tests_Suite
    end

    $scheduler.add(@_tests, true)
    sleep 2 # wait until all tests are added

    $runnungThread = true
    $scheduler.schedule(100)
    $runnungThread = false
    $scheduler.runTests( $_machine == "--server" )
    #!
    saveReport()
  end

  def setAcceptanceTest(test)
    begin
      @_tests << Object.const_get(test)
    rescue
      abort(@console_error_message)
    end
  end

  def setUpSocketOptions(optionsArray)
    optionsArray.each{ |option|
      ARGV << option
    }
    setUpOptions()
  end

  private

  def defineScopeVariable()
    #!  Define scope variables
    @options = {'--save-results' => false,
                '--dev' => false,
                '--prod' => false,
                '--qa' => false,
                '--ff' => false,
                '--ie' => false,
                '--login' => false,
                '--thread' => false,
                '--out' => false,
                '--machine' => false }

    @console_error_message = "
    The syntax of this command is:\truby run_test.rb [OPTIONS] | [CLASSNAMES]\n
    Examples:\n 
    > ruby run_test.rb --prod --ff Tests_Google_ExampleTest
    > ruby server_run_test.rb --qa
    > ruby client_run_test.rb
    
    OPTIONS:\t[ --save-results | --dev | --prod | --qa | --ff | --ie | --chrome | --login | --thread | --out | --local ]
    
    * Verify that all params are valid."

    @_tests = []
    #!
  end

  def defineGlobalVariables()
    #!  Define global variables
    if not File.exists?("config/settings.rb")
      system("sed -e 's/QA/DEV/g' config/settings.rb.tpl > config/settings.rb;")
    end

    $validArguments = []
    $_usingStdOutput = Config_Settings::STD_OUTPUT
    $_machine = ''
    $stdOutput = Lib_Tools_StdOutputProxy.new
    $login = false
    $user = ''
    $runnungThread = false
    $saveResults = false
    $target_server = Config_Settings::TEST_SERVER
    $target_browser = Config_Settings::TEST_BROWSER
    $thread = false
    $report = Lib_Tools_OverallReportsFactory.new
    $scheduler = Lib_TaskScheduler.new
    #!
  end

  def setUpOptions()
    for i in 0..(ARGV.size - 1) do
      param = ARGV[i]
      if (param != nil)
        if (!@options['--save-results'] and param == "--save-results")
          @options['--save-results'] = true
          $saveResults = true
          $validArguments << param
        elsif (!@options['--dev'] and param == "--dev")
          @options['--dev'] = true
          $validArguments << param
          $target_server = Config_Constants::DEV
        elsif (!@options['--qa'] and param == "--qa")
          @options['--qa'] = true
          $validArguments << param
          $target_server = Config_Constants::QA
        elsif (!@options['--prod'] and param == "--prod")
          @options['--prod'] = true
          $validArguments << param
          $target_server = Config_Constants::PROD
        elsif (!@options['--ff'] and param == "--ff")
          @options['--ff'] = true
          $validArguments << param
          $target_browser = Config_Constants::FIREFOX
        elsif (!@options['--ie'] and param == "--ie")
          @options['--ie'] = true
          $validArguments << param
          $target_browser = Config_Constants::IE
        elsif (!@options['--chrome'] and param == "--chrome")
          @options['--chrome'] = true
          $validArguments << param
          $target_browser = Config_Constants::CHROME
        elsif (!@options['--login'] and param == "--login")
          @options['--login'] = true
          $validArguments << param
          $login = true
        elsif (!@options['--thread'] and param == "--thread")
          @options['--thread'] = true
          $validArguments << param
          $thread = !$thread
        elsif (!@options['--out'] and param == "--out")
          @options['--out'] = true
          $validArguments << param
          $_usingStdOutput = true
        elsif (!@options['--machine'] and ["--local","--server"].include?(param))
          @options['--machine'] = true
          $validArguments << param
          $_machine = param
        elsif (param == "--endless")
          # => ignore within this scope         
        else
          begin            
            @_tests << Object.const_get(param)
          rescue
            abort(@console_error_message)
          end
        end
      end
    end
  end

  def initReport()
    $report.openReport(Config_Settings::REPORT_FOLDER_PATH + '/overall_report')
  end

  def saveReport()
    $report.finishReport
  end
end