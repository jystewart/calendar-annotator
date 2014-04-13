Given(/^I have something going on today$/) do
  # We assume this is true based on the fixture data we're using
end

When(/^I sign in and view the day's details on my main calendar$/) do
  visit day_path(:id => 'testuser@testappsdomain.co.uk', :date => Date.today)
  step %{I sign in correctly with google}
end

When(/^I view the day's details on my main calendar$/) do
  visit day_path(:id => 'testuser@testappsdomain.co.uk', :date => Date.today)
end

Then(/^I should be able to add a note to the first calendar item$/) do
  @message = "This one's vital. You want to get to an agreement on X"
  fill_in "Notes", with: @message
  click_button "Save"
end

Then(/^see it again if I reload the page$/) do
  step %{I view the day's details on my main calendar}
  assert page.has_content?(@message)
end