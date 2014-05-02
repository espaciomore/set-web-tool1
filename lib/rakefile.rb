require 'rubygems'
require 'fileutils'

task :default => [:generate_file]

task :generate_file do
  files = [
    'LICENSE.txt.tpl',
    'README.md.tpl',
    'config/settings.rb.tpl',
    'main.rb.tpl',
    'tests/suite.rb.tpl',
    'tests/google/example_test.rb.tpl',
    ]
  
  dirs = [
    'config',
    'reports',
    'sockets/reports'
    'tests/google',
    ] 
     
  dirs.each do |dir|
    FileUtils.mkdir_p ENV['dir']+dir
  end
  
  files.each do |file|
    src_file = File.expand_path( "./" ) +File::SEPARATOR+ file
    dst_file = File.expand_path( ENV['dir'] ) +File::SEPARATOR+ file.gsub(/\.tpl/,'')
    File.open( dst_file, 'w' ) do |f|
      f.write( File.open( src_file ).read )
    end        
  end
end