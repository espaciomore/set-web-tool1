Gem::Specification.new do |s|
  s.name        = 'set-web-tool1'
  s.version     = '0.0.3'
  s.date        = '2013-02-12'
  s.summary     = "A Gem based on watir and selenium-webdriver"
  s.description = "A framework created  at intellisys for developing frontend user acceptance tests"
  s.authors     = ["Manuel Cerda", "Victor Castellanos", "Evelio Fernandez", "William Cabrera"]
  s.licenses    = ["espaciomore","intellisys"]
  s.email       = 'espaciomore@gmail.com'
  s.extra_rdoc_files = [
    "LICENSE.txt"
  ]  
  s.files       = [
    'bootstrap.rb',
    'client_run_test.rb',
    'local_run_test.rb',
    'run_test.rb',
    'server_run_test.rb',
    'test_scaffold.rb',
    'set-web-tool1.gemspec',
    'config/constants.rb',
    'config/report_constants.rb',
    'config/settings.rb',
    'config/settings.rb.tpl',
    'lib/set-web-tool1.rb',
    'lib/acceptance_test.rb',
    'lib/email.rb',
    'lib/server.rb',
    'lib/set-web-tool1.rb',
    'lib/task_scheduler.rb',
    'lib/tools.rb',
    
    ]
  s.require_paths = ["config","lib"]  
  s.homepage    = 'http://github.com/espaciomore/set-web-tools1'
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to?( :required_rubygems_version= )
  
end
