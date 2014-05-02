begin
  $__DIR__ = File.expand_path( File.dirname(__FILE__) )
  require $__DIR__ +"/lib/set-web-tool1"
  require $__DIR__ +"/config/settings.rb"
rescue LoadError => error
  puts "Missing Dependencies:"
  raise error
end

action = ARGV.empty? ? '' : ARGV.reverse.pop 
ARGV.shift

ret = case action
when '' then
  hello
when 'TestScaffold' then
  create_test_scaffold( Config_Settings.new($__DIR__), ARGV )
when 'RunTest' then
  exec_test( Config_Settings.new($__DIR__), ARGV )  
else
  "No such action '#{action}' is available !"
end
puts ret

exit(0)