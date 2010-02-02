require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"

describe "modification" do
  before(:each) do
    @object = Bar.new(1,2)
  end
  describe "changing the state of the same object" do
    it "should set an attribute and get it back" do
      @object.val2 = 99
      @object.val2.should == 99
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

