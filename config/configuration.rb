require File.dirname(__FILE__) + "/constants"

class Configuration
  # Use stderr for std output, to be used by TeamCity
  STD_OUTPUT = true
  
  # Server to run the test
  TEST_SERVER = Constants::DEV

  # Browser to run the test
  TEST_BROWSER = Constants::FIREFOX

  #Folder root
  ROOT_FOLDER_PATH = "./.."

  # Wait timeout for browser requests and wait timer
  WAIT_TIMEOUT = 10

  # Debug mode on
  DEBUG = true

  # Default USER, PASS for application login action
  DEFAULT_USER = 'noodle.test.user@gmail.com'
  DEFAULT_PASS = 'welc0me' # gmail password welc0m31

  # Default USER, PASS for application login action
  REGISTER_USER = 'noodle.resgister.user@gmail.com'
  REGISTER_PASS = '123456' # gmail password welc0m31
  
  # Facebook USER, PASS for FacebookConnect form
  FACEBOOK_USER = 'thisissparta@intellisys.com.do'
  FACEBOOK_PASS = 'W3lc0m31'

  # Provider USER, PASS for application login acction
  PROVIDER_USER = 'alex@noodle.org'
  PROVIDER_PASS = 'noodle'
  
  # Double test with login by default
  TEST_LOGGED_IN = true
  
  # Activate Email Notification
  EMAIL_NOTIFICATION = false
  RECEPIENTS = ['developers.noodle.team@intellisys.com.do','kyle@noodle.org','nstephens@noodle.org']
  
  # Gmail USER, PASS 
  GMAIL_USER = 'noodle.test.user@gmail.com'
  GMAIL_PASS = 'welc0m31'  
  
  # Master / Slave Arquitecture
  CLIENTS = ["127.0.0.1"] # => IP addresses for remote hosts running client_run_test.rb
  CLIENTS_IE = ["127.0.0.1"] # => IP addresses for remote hosts running client_run_test.rb under windows OS
  USERNAME = 'ssh-username' # => Username used by client to connect to server running server_run_test.rb
  HOST = '127.0.0.1' # => IP address for remote server running server_run_test.rb
  PORT = 15000 # => TCPSocket port  
end
