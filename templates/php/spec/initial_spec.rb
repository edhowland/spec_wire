require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
describe "Test server" do
  it "should respond with a simple Status OK" do
    server=SpecWire::Initializer.config.server_url
    JSON.parse(RestClient.get(server))['status'].should == 'OK'
  end
end