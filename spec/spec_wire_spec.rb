require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SpecWire" do
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
end
