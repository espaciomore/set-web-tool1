class Tests_Modules_PeriodicTableTest < Lib_Tests_AcceptanceTest

  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/modules/homepage_periodic_table'
  end

  def testLoggedOut
    return false
  end
  
  def testSite
    return "#{$target_server}/home"
  end
  
  def runTest
    self::testVerticals                                                                                        
  end
  
  def pageOpened text    
    return @generalTools.waitOrCrash(text,5)  
  end
  
  def testVerticals
    options = [{:name=>'Preschool',:url=>'/preschool',:xpath=>'//*[@id="periodicTable"]/tbody/tr[1]/td[1]/div/div/div[1]/a',:text=>'Coming Soon: <span>Preschool</span> Search!'},
               {:name=>'K-8',:url=>'/k-12',:xpath=>'//*[@id="periodicTable"]/tbody/tr[2]/td[1]/div/div/div[2]/a',:text=>'Find the right Kindergarten through High School'},
               {:name=>'High School',:url=>'/k-12',:xpath=>'//*[@id="periodicTable"]/tbody/tr[3]/td[1]/div/div/div[1]/a',:text=>'Find the right Kindergarten through High School'},
               {:name=>'Summer Camp',:url=>'/summer-camp',:xpath=>'//*[@id="periodicTable"]/tbody/tr[4]/td[1]/div/div/div[1]/a',:text=>'Summer Camp search is <span>coming soon</span> to Noodle!'},
               {:name=>'Religious Education',:url=>'/religious-education',:xpath=>'//*[@id="periodicTable"]/tbody/tr[5]/td[1]/div/div/div[1]/a',:text=>'Coming Soon: <span>Religious Education</span> Search'},
               {:name=>'Student Travel',:url=>'/student-travel',:xpath=>'//*[@id="periodicTable"]/tbody/tr[6]/td[1]/div/div/div[1]/a',:text=>'Coming Soon: <span>Student Travel</span> Search'},
               {:name=>'Tutoring',:url=>'/find/tutoring',:xpath=>'//*[@id="periodicTable"]/tbody/tr[2]/td[2]/div/div/div[1]/a',:text=>'<span itemprop="title">Academic Tutoring</span>'},
               {:name=>'Test Prep',:url=>'/find/test-prep',:xpath=>'//*[@id="periodicTable"]/tbody/tr[3]/td[2]/div/div/div[1]/a',:text=>'<span itemprop="title">Test Prep</span>'},
               {:name=>'Guidance Counseling',:url=>'/find/guidance-counseling',:xpath=>'//*[@id="periodicTable"]/tbody/tr[4]/td[2]/div/div/div[2]/a',:text=>'<span itemprop="title">Guidance Counseling</span>'},
               {:name=>'Learning Disabilities',:url=>'/learning-disabilities',:xpath=>'//*[@id="periodicTable"]/tbody/tr[5]/td[2]/div/div/div[2]/a',:text=>'Coming Soon: Search for Resources for <span>Learning Disabilities</span>'},
               {:name=>'After School',:url=>'/after-school',:xpath=>'//*[@id="periodicTable"]/tbody/tr[6]/td[2]/div/div/div[1]/a',:text=>'After School search is <span>coming soon</span> to Noodle!'},
               {:name=>'Art & Design',:url=>'/art-design',:xpath=>'//*[@id="periodicTable"]/tbody/tr[5]/td[3]/div/div/div[2]/a',:text=>'Art and Design classes are <span>coming soon</span> to Noodle!'},
               {:name=>'Fitness',:url=>'/fitness',:xpath=>'//*[@id="periodicTable"]/tbody/tr[6]/td[3]/div/div/div[1]/a',:text=>'Fitness classes are <span>coming soon</span> to Noodle!'},
               {:name=>'Music',:url=>'/music',:xpath=>'//*[@id="periodicTable"]/tbody/tr[5]/td[4]/div/div/div[1]/a',:text=>'Music lessons and teachers are <span>coming soon</span> to Noodle'},
               {:name=>'Dance',:url=>'/dance',:xpath=>'//*[@id="periodicTable"]/tbody/tr[5]/td[5]/div/div/div[1]/a',:text=>'Dance classes are <span>coming soon</span> to Noodle!'},
               {:name=>'Language Instruction',:url=>'/language-instruction',:xpath=>'//*[@id="periodicTable"]/tbody/tr[6]/td[4]/div/div/div[1]/a',:text=>'Willkommen! Language classes are <span>coming soon</span> to Noodle!'},
               {:name=>'Sports Coaching',:url=>'/sports-coaching',:xpath=>'//*[@id="periodicTable"]/tbody/tr[6]/td[5]/div/div/div[1]/a',:text=>'Sports coaching is <span>coming soon</span> to Noodle!'},
               {:name=>'College',:url=>'/find/college',:xpath=>'//*[@id="periodicTable"]/tbody/tr[2]/td[6]/div/div/div[1]/a',:text=>'<span itemprop="title">College</span>'},
			         {:name=>'Continuing Education',:url=>'/continuing-education',:xpath=>'//*[@id="periodicTable"]/tbody/tr[1]/td[8]/div/div/div[1]/a',:text=>'Continuing education classes are <span>coming soon</span> to Noodle!'},
               {:name=>'Internships',:url=>'/internships',:xpath=>'//*[@id="periodicTable"]/tbody/tr[2]/td[8]/div/div/div[1]/a',:text=>'Coming Soon: Find the perfect <span>internship</span> with Noodle!'},
               {:name=>'Technology',:url=>'/technology',:xpath=>'//*[@id="periodicTable"]/tbody/tr[3]/td[8]/div/div/div[1]/a',:text=>'Technology education search is <span>coming soon</span> to Noodle!'},
               {:name=>'Professional Development',:url=>'/professional-development',:xpath=>'//*[@id="periodicTable"]/tbody/tr[4]/td[8]/div/div/div[1]/a',:text=>'Professional development programs are <span>coming soon</span> to Noodle!'},
               {:name=>'Career Counseling',:url=>'/career-counseling',:xpath=>'//*[@id="periodicTable"]/tbody/tr[5]/td[8]/div/div/div[1]/a',:text=>'Career counselors are <span>coming soon</span> to Noodle!'},
               {:name=>'Vocational Schools',:url=>'/vocational-schools',:xpath=>'//*[@id="periodicTable"]/tbody/tr[4]/td[6]/div/div/div[1]/a',:text=>'Vocational Schools are <span>coming soon</span> to Noodle!'},
               {:name=>'Study Abroad',:url=>'/find/study-abroad',:xpath=>'//*[@id="periodicTable"]/tbody/tr[5]/td[6]/div/div/div[1]/a',:text=>'<span itemprop="title">Study Abroad</span>'},
               {:name=>'Graduate School',:url=>'/find/graduate',:xpath=>'//*[@id="periodicTable"]/tbody/tr[2]/td[7]/div/div/div[1]/a',:text=>'<span itemprop="title">Graduate</span>'},
               {:name=>'Law',:url=>'/find/law',:xpath=>'//*[@id="periodicTable"]/tbody/tr[3]/td[7]/div/div/div[1]/a',:text=>'<span itemprop="title">Law</span>'},
               {:name=>'MBA',:url=>'/find/mba',:xpath=>'//*[@id="periodicTable"]/tbody/tr[4]/td[7]/div/div/div[2]/a',:text=>'<span itemprop="title">MBA</span>'},
               {:name=>'Medical',:url=>'/medical/search',:xpath=>'//*[@id="periodicTable"]/tbody/tr[5]/td[7]/div/div/div[2]/a',:text=>'<span itemprop="title">Medical</span>'}]
    options.each do |option|
      begin
        @generalTools.verifyText('<span class="buttonTitle">+ Start a New Search</span>', 10)
        @watir_helper.reset.abutton(:xpath => '//*[@id="startNewSearch"]').click
        sleep 1
        @watir_helper.reset.abutton(:xpath => option[:xpath]).clickOn
        gotToSite = @generalTools.waitUrl("#{$target_server}#{option[:url]}")
        hadText =  self::pageOpened(option[:text])
        result = (gotToSite && hadText)
        @watir_helper.goto testSite
      rescue
        result = false
        overall_result = false
      end  
      update_report('[Periodic Table] Test that the vertical "'+ option[:name] +'" buttons are active', 
                    result) 
    end   
  end
end