$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'spec_wire'
require 'spec'
require 'spec/autorun'

# load extra matchers
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

SpecWire::Initializer.run do |config|
  # config.server_url = 'http://localhost/~edh/limonade/server.php'
  # config.session_key = 'Fresh_and_Minty_Limonade_App'
  # config.put_needs_method_arg = true 
  config.class_cache = 'tmp/class_cache'
end


Spec::Runner.configure do |config|
  
end
