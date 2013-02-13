class ServerRunTest

  @@params = ARGV.join(' ')
  @@_endless = @@params.include?('--endless')  
  
  def initialize()
    STDOUT.sync = true
    self::run()
  end   

  def run()
    while(true)
      $stdout.flush
      system("git pull")
      system("ruby run_test.rb #{@@params} --server")
      if !@@_endless
        break
      end
      sleep(25200) if @@_endless
    end 
  end
end