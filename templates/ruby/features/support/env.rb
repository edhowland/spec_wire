$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'spec_wire'

require 'spec/expectations'

SpecWire::Initializer.run do |config|
  config.class_cache = 'tmp/class_cache'
end
