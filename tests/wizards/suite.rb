class Tests_Wizards_Suite
  attr_accessor :tests
  
  def test
    if $thread
      @tests = [
              Tests_Wizards_College_WizardTest,
              Tests_Wizards_K12_WizardTest,
              Tests_Wizards_TestPrep_WizardTest,
              Tests_Wizards_Tutoring_WizardTest,
              Tests_Wizards_Mba_WizardTest,
              Tests_Wizards_Law_WizardTest,
              Tests_Wizards_GuidanceCounseling_WizardTest,
              Tests_Wizards_Graduate_WizardTest,
              Tests_Wizards_Medical_WizardTest,
              Tests_Wizards_StudyAbroad_WizardTest,
              ]
      
      $scheduler.add(@tests, true)
    end
    
    @tests = [
            Tests_Wizards_College_WizardTest,
            Tests_Wizards_K12_WizardTest,
            Tests_Wizards_TestPrep_WizardTest,
            Tests_Wizards_Tutoring_WizardTest,
            Tests_Wizards_Mba_WizardTest,
            Tests_Wizards_Law_WizardTest,
            Tests_Wizards_GuidanceCounseling_WizardTest,
            Tests_Wizards_Graduate_WizardTest,
            Tests_Wizards_Medical_WizardTest,
            Tests_Wizards_StudyAbroad_WizardTest,
            ]
    
    $scheduler.add(@tests)  
  end
end