class TestScaffold
  
  include Libs_Modules_NameTranslator
  
  def initialize
  end
  
  def initialize(settings, args)
    begin      
      scaffolding = %Q{class #{args[0]} < Libs_AcceptanceTest
  def getReportPath
    raise NotImplementedException
  end
  
  def testLoggedIn
    raise NotImplementedException
  end
  
  def testSite
    raise NotImplementedException
  end
  
  def runTest
    raise NotImplementedException
  end                  
end
      }
      s = File::SEPARATOR
      full_path = explode_class_name(args[0])
      base_path = settings.root_folder_path
      file_name = "#{full_path.pop}.rb"
      FileUtils.mkdir_p full_path.join(s)
      
      File.open(base_path +s+ full_path.join(s) +s+ file_name, 'w') do |f|
        f.write(scaffolding)
      end
    rescue Exception => e
      puts "FAILED to create test scaffold: #{e}"  
    end
  end
end