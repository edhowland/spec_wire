Before do
  @calculator = Calculator.new
end 
Given /^I have entered (.*) into the calculator$/ do |n|
  @calculator.push n
end
When /^I press add$/ do
  @result = @calculator.add(nil)
end
Then /^the result should be (.*) on the screen$/ do |expected|
  @result.should == expected.to_i
end
