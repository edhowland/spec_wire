require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Error Handling" do
  it "should raise an error for class not found" do
    lambda {obj = NotFoundClass.new}.should raise_error
  end
  describe "Bar" do
    before(:each) do
      @obj = Bar.new(1,2)
    end
    it "should report an error for invalid method call" do
      lambda {@obj.no_method(nil)}.should raise_error 
    end
  end
  describe "Getting the marshalled exception" do
    it "should report LoadError" do
      lambda {Xzzy.new}.should raise_error(LoadError)
    end
    it "should raise ArgumentError for Bar.new" do
      lambda {Bar.new}.should raise_error(ArgumentError)
    end
  end
  
end