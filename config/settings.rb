class Config_Settings
  # Use stderr for std output, to be used by TeamCity
  STD_OUTPUT = true
  
  # Server to run the test
  TEST_SERVER = Constants::DEV

  # Browser to run the test
  TEST_BROWSER = Constants::FIREFOX

  #Folder root
  ROOT_FOLDER_PATH = File.dirname(__FILE__) + "/.."

  # Wait timeout for browser requests and wait timer
  WAIT_TIMEOUT = 10

  # Debug mode on
  DEBUG = true

  # Default USER, PASS for application login action
  DEFAULT_USER = 'username@domain'
  DEFAULT_PASS = 'password' 
  
  # Double test with login by default
  TEST_LOGGED_IN = true
  
  # Activate Email Notification
  EMAIL_NOTIFICATION = false
  RECEPIENTS = ['espaciomore@gmail.com'] 
  
  # Master / Slave Arquitecture
  CLIENTS = ["127.0.0.1"] # => IP addresses for remote hosts running client_run_test.rb
  CLIENTS_IE = ["127.0.0.1"] # => IP addresses for remote hosts running client_run_test.rb under windows OS
  USERNAME = 'ssh-username' # => Username used by client to connect to server running server_run_test.rb
  HOST = '127.0.0.1' # => IP address for remote server running server_run_test.rb
  PORT = 15000 # => TCPSocket port  
end
