# environment.rb
# included from spec/spec_helper.rb
# defines constants like server_url which points to the REST
# server. E.g. to switch between running the specs on the Ruby 
# server (default) and the PHP server
# config.server = 'http://localhost/~user/limonade/server.php'
require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', 'initializer')


SpecWire::Initializer.run do |config|
  # set the configuration server url to something else
  # e.g. PHP:
  # config.server_url = 'http://localhost/limonade/server.php'

  config.server_url = 'http://localhost/~edh/limonade/server.php'
end


