class TestScaffold
  
  include Lib_Modules_NameTranslator
  
  def initialize
    begin
      klass_name = ARGV[0]
      
      scaffolding = %Q{class #{klass_name} < Lib_AcceptanceTest
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
      
      full_path = explode_class_name(klass_name)
      file_name = "#{full_path.pop}.rb"
      FileUtils.mkdir_p full_path.join('/')
      
      File.open(File.dirname(__FILE__)+'/'+full_path.join('/')+'/'+file_name, 'w') do |f|
        f.write(scaffolding)
      end
    rescue Exception => e
      puts "FAILED to create test scaffold: #{e}"  
    end
  end
end