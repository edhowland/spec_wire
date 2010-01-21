require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', 'initializer')
# require File.expand_path(File.dirname(__FILE__)) + '/support/matchers/blank'
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}


describe "SpecWire::Initializer" do
  before(:all) do
    SpecWire::Initializer.run do |config|
      config.server_url = 'http://localhost/~user/limonade/server.php'
    end
  end
  after(:all) do
    SpecWire::Initializer.reset_to_defaults
    SpecWire::Initializer.config.server_url.should == 'http://localhost:4567'
  end
  it "should have a config.server_url of 'http://localhost/~user/limonade/server.php'" do
    SpecWire::Initializer.config.server_url.should == 'http://localhost/~user/limonade/server.php'
  end
  it "should reinitialize to default settings" do
    SpecWire::Initializer.reset_to_defaults
    SpecWire::Initializer.config.server_url.should == 'http://localhost:4567'
  end
  it "should have a class_cache" do
    SpecWire::Initializer.reset_to_defaults
    SpecWire::Initializer.config.class_cache.should_not be_blank    
  end
  it "class_cache should exist" do
    SpecWire::Initializer.reset_to_defaults
    SpecWire::Initializer.config.class_cache.should exist
  end
end