class Config_Settings
  def initialize(dir)
    @__DIR__ = dir
  end
  
  # Use stderr for std output, to be used by TeamCity
  def std_output
    true
  end
  
  # Server to run the test
  def test_server
    'http://www.google.com'
  end
  
  # Browser to run the test
  def test_browser
    :ff
  end

  #Folder root
  def root_folder_path
    @__DIR__ 
  end
  
  def report_folder_path
   root_folder_path + "/reports"
  end

  def socket_folder_path
   root_folder_path + "/sockets/reports"
  end  

  # Wait timeout for browser requests and wait timer
  def wait_timeout
    10
  end

  # Debug mode on
  def debug
    true
  end

  # Default USER, PASS for application login action
  def default_user
    'username@domain'
  end
  
  def default_pass
    'password' 
  end
  
  # Double test with login by default
  def test_logged_in
    true
  end
  
  # Activate Email Notification
  def email_notification
    false
  end
  
  def recepients
    ['espaciomore@gmail.com'] 
  end
  
  # Master / Slave Arquitecture
  def clients
    ["127.0.0.1"] # => IP addresses for remote hosts running client_run_test.rb
  end
  
  def clients_ie
    ["127.0.0.1"] # => IP addresses for remote hosts running client_run_test.rb under windows OS
  end
  
  def username
    'ssh-username' # => SSH username used by client to connect to server running server_run_test.rb
  end
  
  def host_pwd
    'password' # => SSH password used by client to connect to server running server_run_test.rb
  end
  
  def host
    '127.0.0.1' # => IP address for remote server running server_run_test.rb
  end
  
  def port
    15000 # => TCPSocket port  
  end
end
