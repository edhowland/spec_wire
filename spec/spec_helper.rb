$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'spec_wire'
require 'spec'
require 'spec/autorun'
require 'const'

Spec::Runner.configure do |config|
  
end
