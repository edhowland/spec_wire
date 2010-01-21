require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
describe "Blank matcher" do
  it "'' should be blank" do
    "".should be_blank
  end
  it "nil should be blank" do
    nil.should be_blank
  end
  it "[] should be blank" do
    [].should be_blank
  end
  it "{} should be blank" do
    {}.should be_blank
  end
  it "'a' should not be blank" do
    "a".should_not be_blank
  end
  it "[1] should not be blank" do
    [1].should_not be_blank
  end
  it "{:a=>1} should not be blank" do
    {:a=>1}.should_not be_blank
  end
  it "should raise error if not blank" do
    lambda {"1".should be_blank}.should raise_error
  end
  it "should raise error if not empty" do
    lambda {[1].should be_blank}.should raise_error
  end
  it "should raise error if not empty" do
    lambda {[].should_not be_blank}.should raise_error
  end
end
