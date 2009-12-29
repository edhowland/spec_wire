require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
describe "Bar" do
  before(:each) do
    @obj = Bar.new(1,2)
  end
  it "val1 should be 1" do
    @obj.val1.should == 1
  end
  it "val2 should be 1" do
    @obj.val2.should == 2
  end
end