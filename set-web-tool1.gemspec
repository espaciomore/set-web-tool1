Gem::Specification.new do |s|
  s.name        = 'set-web-tool1'
  s.version     = '1.0.1'
  s.date        = '2013-02-13'
  s.summary     = "A Gem based on watir and selenium-webdriver"
  s.description = "A framework created  at intellisys for developing frontend user acceptance tests"
  s.authors     = ["Manuel Cerda", "Victor Castellanos", "Evelio Fernandez", "William Cabrera","Kelvin de Moya"]
  s.licenses    = ["espaciomore","intellisys"]
  s.email       = 'espaciomore@gmail.com'
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md",
  ]  
  s.files       = [
    'lib/config/constants.rb',
    'lib/config/report_constants.rb',
    'lib/config/settings.rb',
    'lib/config/settings.rb.tpl',
    'lib/libs/modules/client_connection.rb',
    'lib/libs/modules/name_translator.rb',
    'lib/libs/tools/overall_reports_factory.rb',
    'lib/libs/tools/reports.rb',
    'lib/libs/tools/std_output_proxy.rb',
    'lib/libs/tools/std_output.rb',
    'lib/libs/tools/test_reports_factory.rb',
    'lib/libs/tools/watir_helper.rb',
    'lib/libs/acceptance_test.rb',
    'lib/libs/email.rb',
    'lib/libs/server.rb',
    'lib/libs/task_scheduler.rb',
    'lib/libs/tools.rb',
    'lib/tests/suite.rb.tpl',
    'lib/tests/suite.rb',
    'lib/tests/google/example_test.rb.tpl',
    'lib/tests/google/example_test.rb',
    'lib/bootstrap.rb',
    'lib/client_run_test.rb',
    'lib/LICENSE.txt.tpl',
    'lib/local_run_test.rb',
    'lib/main.rb.tpl',
    'lib/main.rb',
    'lib/rakefile.rb',
    'lib/README.md.tpl',
    'lib/run_test.rb',
    'lib/server_run_test.rb',
    'lib/set-web-tool1.rb',
    'lib/test_scaffold.rb',
    'set-web-tool1.gemspec',    
    ]
  s.require_paths = ['config','libs','tests']  
  s.homepage    = 'http://github.com/espaciomore/set-web-tools1'
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to?( :required_rubygems_version= )
  
end
