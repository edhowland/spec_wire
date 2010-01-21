require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
describe "Exist matcher" do
  it "dir tmp/class_cache should exist" do
    "tmp/class_cache".should exist
  end
  it "dir tmp/xxx should not exist" do
    "tmp/xxx".should_not exist
  end
  it "file spec/spec_helper.rb should exist" do
    "spec/spec_helper.rb".should exist
  end
  it "file spec/xxx should not exist" do
    "spec/xxx".should_not exist
  end
  
end