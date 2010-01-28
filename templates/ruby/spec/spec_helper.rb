$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'spec_wire'
require 'spec'
require 'spec/autorun'

SpecWire::Initializer.run do |config|
  config.class_cache=File.expand_path(File.dirname(__FILE__)) + '/tmp/class_cache'
end

# load extra matchers
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

Spec::Runner.configure do |config|
  
end
