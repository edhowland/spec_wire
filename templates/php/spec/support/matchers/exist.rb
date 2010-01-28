Spec::Matchers.define :exist do
  match do |actual|
    File.exists? actual
  end
  
  failure_message_for_should do |actual|
    "expected #{actual} would exist"
  end
  
  failure_message_for_should_not do |actual|
    "expected #{actual} would not exist"
  end
end
