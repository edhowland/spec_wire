require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
describe "Myfoo" do
  before(:each) do
    @obj = Myfoo.new(1)
  end
  it "should not be nil" do
    @obj.should_not be_nil
  end
  it "should have meta" do
    @obj.meta.should_not be_blank
  end
  it "val1 should be 1" do
    @obj.val1.should == 1
  end
end