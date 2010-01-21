Spec::Matchers.define :be_blank do
  match do |actual|
    actual.nil? || actual.empty?
  end
  
  failure_message_for_should do |actual|
    "expected #{actual.inspect} would be blank"
  end
  
  failure_message_for_should_not do |actual|
    "expected #{actual.inspect} would not be blank"
  end
end
    