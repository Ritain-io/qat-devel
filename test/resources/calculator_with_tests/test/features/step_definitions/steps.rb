Before do
  @calculator=Calculator.new
end
Given /I have entered (\d+(?:,\d+)?) into the calculator/ do |n|
  @calculator.push(n.gsub(",", ".").to_f)
end


When(/^I press add$/) do
  @calculator.add
end


When(/^I press sub$/) do
  @calculator.sub
end

When(/^I press mult$/) do
  @calculator.mult
end

When(/^I press div$/) do
  @calculator.div
end

When(/^I press floatadd$/) do
  @calculator.add
end
Then(/^the result should be (\d+(?:,\d+)?) on the screen$/) do |result|

  #assert_equals(result.to_f,@calculator.val)
  assert_in_delta(result.gsub(",", ".").to_f, @calculator.val, 0.00001)
end