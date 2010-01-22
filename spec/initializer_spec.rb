require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', 'spec_wire', 'initializer')
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

@saved_config
describe "SpecWire::Initializer" do
  before(:all) do
    @saved_config = SpecWire::Initializer.config 
    SpecWire::Initializer.run do |config|
      config.server_url = 'http://localhost/~user/limonade/server.php'
    end
  end
  after(:all) do
    SpecWire::Initializer.config = @saved_config
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
  it "class_cache should not exist" do
    SpecWire::Initializer.reset_to_defaults
    SpecWire::Initializer.config.class_cache.should_not exist
  end
  it "should save a copy of the class" do
    SpecWire::Initializer.config = SpecWire::Initializer.new
  end
end