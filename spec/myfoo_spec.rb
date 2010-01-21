require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
describe "Foo" do
  before(:each) do
    @obj = Foo.new(1)
  end
  it "val1 should be 1" do
    @obj.val1.should == 1
  end
end