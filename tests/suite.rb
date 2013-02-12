class Tests_Suite
  attr_accessor :tests
  
  def test
    @tests = [    
            Tests_Wizards_Suite,
            #Tests_LandingPages_Suite,
            Tests_NeedRegistration_Suite,
            Tests_Provider_Suite,
            Tests_Noodlings_Suite,
            Tests_SignInOut_Suite,
            Tests_Listings_Suite,
            Tests_Leads_Suite,
            #Tests_HeaderSearch_Suite, #watir send_keys method is not reliable
            ]
    
    $scheduler.add(@tests)   
    
    #*************************************
        
    @tests = [      
            Tests_About_Suite,
            Tests_EmailLink_Suite,
            Tests_Marketing_Suite,
            Tests_HomeSite_Suite,
            Tests_Modules_Suite,
            Tests_China_Suite,
            Tests_Sitemap_Suite,
            Tests_StaticPages_Suite,
            Tests_DynamicPages_Suite,
            Tests_MonitoringService_Suite,
            Tests_CompanyProfiles_Suite,
            ]
           
    $scheduler.add(@tests,true)
  end
end