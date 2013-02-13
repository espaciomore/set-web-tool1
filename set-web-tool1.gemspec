Gem::Specification.new do |s|
  s.name        = 'set-web-tool1'
  s.version     = '1.0.0'
  s.date        = '2013-02-12'
  s.summary     = "A Gem based on watir and selenium-webdriver"
  s.description = "A framework created  at intellisys for developing frontend user acceptance tests"
  s.authors     = ["Manuel Cerda", "Victor Castellanos", "Evelio Fernandez", "William Cabrera"]
  s.licenses    = ["espaciomore","intellisys"]
  s.email       = 'espaciomore@gmail.com'
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md",
    "USERGUIDE.md",
  ]  
  s.files       = [
    'lib/acceptance_test.rb',
    'lib/bootstrap.rb',
    'lib/client_run_test.rb',
    'lib/email.rb',
    'lib/local_run_test.rb',
    'lib/run_test.rb',
    'lib/server_run_test.rb',
    'lib/server.rb',
    'lib/set-web-tool1.rb',
    'lib/task_scheduler.rb',
    'lib/test_scaffold.rb',
    'lib/tools.rb',
    'lib/config/constants.rb',
    'lib/config/report_constants.rb',
    'lib/config/settings.rb',
    'lib/config/settings.rb.tpl',
    'lib/modules/client_connection.rb',
    'lib/modules/name_translator.rb',
    'lib/tests/suite.rb',
    'lib/tests/google/example_test.rb',
    'lib/tools/overall_reports_factory.rb',
    'lib/tools/reports.rb',
    'lib/tools/std_output_proxy.rb',
    'lib/tools/std_output.rb',
    'lib/tools/test_reports_factory.rb',
    'lib/tools/watir_helper.rb',
    'set-web-tool1.gemspec',    
    ]
  s.require_paths = ["rubygems"]  
  s.homepage    = 'http://github.com/espaciomore/set-web-tools1'
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to?( :required_rubygems_version= )
  
end
