require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'fileutils'
require 'rest_client'
require 'json'


describe "SpecWire" do
  include FileUtils
  def server_url
    SpecWire::Initializer.config.server_url
  end
  
  before(:all) do
    rm(Dir.glob(File.join(File.expand_path(File.dirname(__FILE__)), '..', 'tmp', 'class_cache') + '/*'))
  end
  
  before(:each) do
    @object = Bar.new(1,2)
  end

  it "should not be nil" do
    @object.should_not be_nil
  end
  it "should have an id" do
    @object.our_id.should_not be_nil
  end
  describe "sending messgaes" do
    it "should have val1 == 1" do
      @object.val1.should == 1
    end
    it "should have val2 == 2" do
      @object.val2.should == 2
    end
  end
  describe "sending class level message" do
    it "should call find with arguments" do
      Bar.find(1).should_not be_nil
    end
    it "should call locate with no args" do
      Bar.locate.should_not be_nil
    end
    it "should respond to find with a list" do
      Bar.find(1).should be_kind_of Array
    end
  end
  describe "server_url" do
    it "should be Sinatra localhost at 4567" do
      server_url.should == 'http://localhost:4567'
    end
  end
  describe "raw get of an object" do
    it "should resolve to the same object" do
      JSON.parse(RestClient.get("#{server_url}/object/" + @object.our_id.to_s)).should == {'json_class' => 'Bar', 'data' => [1, 2], 'id' => @object.our_id}   
    end
  end
end
