require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'fileutils'
require 'rest_client'
require 'json'


describe "SpecWire" do
  include FileUtils
  RestClient.log = '/tmp/rest_client.log'
  def server_url
    SpecWire::Initializer.config.server_url
  end
  def session_key
    SpecWire::Initializer.config.session_key
  end
  
  before(:all) do
    # rm(Dir.glob(File.join(File.expand_path(File.dirname(__FILE__)), '..', 'tmp', 'class_cache') + '/*'))
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
  describe "session handling" do
    before(:each) do
      @resp = RestClient.post("#{server_url}/class/Bar", :args => JSON.generate([1,2])) 
    end
    it "should set have some cookies" do
      @resp.cookies.should_not be_nil
    end
    it "should set the session cookie" do
      @resp.cookies[session_key].should_not be_nil
    end
    
    it "should send the cookies back" do
      obj_hash = JSON.parse(@resp)
      # obj_hash['json_class'].should == 'Bar'
      id = obj_hash['id'] 
      JSON.parse(RestClient.get("#{server_url}/object/#{id}", :cookies => @resp.cookies)).should == 
        {'json_class' => 'Bar', 
          'data' => [1,2], 
          'id' => id}
    end
    it "should send the cookies back in a PUT with args payload=[]" do
      obj_hash = JSON.parse(@resp)
      id = obj_hash['id']
      RestClient.put("#{server_url}/object/#{id}/msg/val1", 
        {:args => JSON.generate([])}, {:cookies => @resp.cookies})
    end
  end
  
  describe "raw get of an object" do
    it "should have cookies" do
      @object.session_cookies.should_not be_nil
    end
    
    it "should resolve to the same object" do
      # puts "object.our_id #{@object.our_id}"
      JSON.parse(RestClient.get("#{server_url}/object/" + 
        @object.our_id.to_s, :cookies =>  @object.session_cookies)).should == 
        {'json_class' => @object.class.name, 
          'data' => [1, 2], 
          'id' => @object.our_id}   
    end
  end
  describe "modifying the state of the same object" do
    it "should set an attribute and get it back" do
      @object.val1 = 99
      @object.val1.should == 99
    end
  end
  describe "sending complex objects and getting them back" do
    it "should send a Hash" do
      @object.val1 = {:size => 1000}
      @object.val1.should == {'size' => 1000}
    end
    
    it "should send a complex hash" do
      @object.val1 = {:gum => 'fatal', :inner => 
          {:really => {
              :something => 'fishy'
          }}}
      @object.val1.should == {'gum' => 'fatal', 'inner' => 
          {'really' => {
              'something' => 'fishy'
          }}}
      
    end
  end
end
