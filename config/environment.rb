# environment.rb
# included from spec/spec_helper.rb
# defines constants like server_url which points to the REST
# server. E.g. to switch between running the specs on the Ruby 
# server (default) and the PHP server
# config.server = 'http://localhost/~user/limonade/server.php'
# require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', 'initializer')


SpecWire::Initializer.run do |config|
  # set the configuration server url to something else
  # The session key is the session cookie key
  # config.session_ley = 'rack.session'  # default
  # Defines whether to use a straight HTTP PUT verb or to simulate with
  # a field: _method=PUT. The latter seems to be needed for Apache+liomade.php
  # config.put_needs_method_arg = true 

  # PHP: uncomment these for PHP, set aerver_url to your url
  # config.server_url = 'http://localhost/~edh/limonade/server.php'
  # config.session_key = 'Fresh_and_Minty_Limonade_App'
  # config.put_needs_method_arg = true 

  # Ruby: uncomment these for Ruby or comment out the above, as these are the default
  # config.server_url = 'http://localhost:4567/  #default Sinatra server
  # config.session_ley = 'rack.session'  # default
  # config.put_needs_method_arg = false
  config.class_cache=File.expand_path(File.dirname(__FILE__)) + '/../tmp/class_cache'
end


