class TestScaffold
  
  include Libs_Modules_NameTranslator
  
  def initialize
  end
  
  def initialize(root_path, klass_name)
    begin      
      scaffolding = %Q{class #{klass_name} < Libs_AcceptanceTest
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
      full_path = explode_class_name(klass_name)
      file_name = "#{full_path.pop}.rb"
      FileUtils.mkdir_p full_path.join(s)
      
      File.open(root_path +s+ full_path.join(s) +s+ file_name, 'w') do |f|
        f.write(scaffolding)
      end
    rescue Exception => e
      puts "FAILED to create test scaffold: #{e}"  
    end
  end
end