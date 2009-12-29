$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'config'))
require 'rubygems'
require 'spec_wire'
require 'spec'
require 'spec/autorun'
require 'environment'
require 'const'

Spec::Runner.configure do |config|
  
end
