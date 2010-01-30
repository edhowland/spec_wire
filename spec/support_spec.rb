require File.join(File.expand_path(File.dirname(__FILE__)), "..", "servers", "support", "env")

describe "Env" do
  describe "to CamelCase" do
    it "should capitalize" do
      "lower".capitalize.should == "Lower"
    end
    it "should genearate CamelCase from camel_case" do
      "camel_case".to_camelcase.should == "CamelCase"
    end
    it "should generate CamelLongCase for camel_long_case" do
      "camel_long_case".to_camelcase.should == "CamelLongCase"
    end
    it "should generate Camel from camel" do
      "camel".to_camelcase.should == "Camel"
    end
    it "should leave CamelCase unchanged" do
      "CamelCase".to_camelcase.should == "CamelCase"
    end
  end
  describe "from CamelCase" do
    it "should generate camel_case from CamelCase" do
      "CamelCase".to_underscores.should == "camel_case"
    end
    it "should generate camel_leng_case from CamelLongCase" do
      "CamelLongCase".to_underscores.should == "camel_long_case"
    end
    it "should generate camel from Camel" do
      "Camel".to_underscores.should == "camel"
    end
    it "should generate camel from camel" do
      "camel".to_underscores.should == "camel"
    end
    it "should leave camel_long_case unchanged" do
      "camel_long_case".to_underscores.should == "camel_long_case"
    end
  end
  describe "load_class_file" do
    it "should not raise error for foo_baz.rb" do
      lambda {load_class_file('FooBaz')}.should_not raise_error
    end
    it "should raise error for missing FooBar" do
      lambda {load_class_file('FooBar')}.should raise_error(LoadError)
    end
  end
end