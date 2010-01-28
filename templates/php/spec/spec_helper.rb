$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'spec_wire'
require 'spec'
require 'spec/autorun'

SpecWire::Initializer.run do |config|
  config.server_url = 'http://localhost/~edh/concrete5.3.3.1/blocks/sanechild/spec/server/server.php'
  config.session_key = 'Fresh_and_Minty_Limonade_App'
  config.put_needs_method_arg = true 
  config.class_cache=File.expand_path(File.dirname(__FILE__)) + '/tmp/class_cache'
end

# load extra matchers
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

Spec::Runner.configure do |config|
  
end
