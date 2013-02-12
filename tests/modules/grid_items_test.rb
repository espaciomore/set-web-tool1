class Tests_Modules_GridItemsTest < Lib_Tests_AcceptanceTest
  def getReportPath
    return Config_Paths::REPORT_FOLDER_PATH + '/grid_view_items/stand_alone_test'
  end
  
  def testSite
    return "#{$target_server}/home"
  end  

  def testLoggedOut
    return false
  end
    
  def runTest    
    testGVI
  end
  
  private
  def testGVI
    gridItems = [{:title => 'College',:item => Tests_Wizards_College_GridItemTest},
                 {:title => 'Graduate',:item => Tests_Wizards_Graduate_GridItemTest},
                 {:title => 'Guidance Counseling',:item => Tests_Wizards_GuidanceCounseling_GridItemTest},
                 {:title => 'Law',:item => Tests_Wizards_Law_GridItemTest},
                 {:title => 'MBA',:item => Tests_Wizards_Mba_GridItemTest},
                 {:title => 'Medical',:item => Tests_Wizards_Medical_GridItemTest},
                 {:title => 'K-12',:item => Tests_Wizards_Schools_GridItemTest},                                 
                 {:title => 'Study Abroad',:item => Tests_Wizards_StudyAbroad_GridItemTest},
                 {:title => 'Test Prep',:item => Tests_Wizards_TestPrep_GridItemTest},
                 {:title => 'Academic Tutoring',:item => Tests_Wizards_Tutoring_GridItemTest}
                 ]
    gridItems.each do |gridItem|      
      @browser.goto testSite
      @generalTools.waitUrl testSite
      @watir_helper.find(:xpath => "//li[@title=\"#{gridItem[:title]}\"]")
      @watir_helper.click
      _this = gridItem[:item].new(@generalTools)
      @generalTools.setGVI _this
      _this.testGridItem("Grid View Item][#{gridItem[:title]}") 
    end       
  end
end