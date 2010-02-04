$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'spec_wire'

require 'spec/expectations'

SpecWire::Initializer.run do |config|
  config.server_url = 'http://localhost/~edh/limonade/server.php'
  config.session_key = 'Fresh_and_Minty_Limonade_App'
  config.put_needs_method_arg = true 
  config.class_cache = 'tmp/class_cache'
end
