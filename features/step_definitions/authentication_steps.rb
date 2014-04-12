Given(/^that I have mocked a successful google authentication$/) do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    :credentials => {
      :token => 'my_token',
      :refresh_token => 'refresh_me',
      :expires => true,
      :expires_at => 1.year.from_now.to_i
    },
    :info => {
      :name => "James Stewart",
      :email => 'testing@gmail.com',
      :first_name => "James",
      :last_name => "Stewart",
      :image => "https://lh6.googleusercontent.com/-aYliX3Ex_xc/AAAAAAAAAAI/AAAAAAAACME/Lx51HltY7uU/photo.jpg",
      :urls => {
        "Google" => "https://plus.google.com/104661308997486416661"
      }
    },
    :extra => {
      :id_token => "usually_very_lengthy",
      :raw_info => {
        :id => "my_fake_uid",
        :email => 'testing@gmail.com',
        :verified_email => true,
        :name => "James Stewart",
        :given_name => "James",
        :family_name => "Stewart"
      }
    },
    :provider => 'google_oauth2',
    :uid => "my_fake_uid"
  })
end

When(/^I go to the dashboard$/) do
  visit "/"
end

When(/^I sign in correctly with google$/) do
  click_link "Sign in now"
end

Then(/^I should see a list of my calendars$/) do
  assert page.has_content?("My Calendars"), "Missing content\n\n#{page.body}"
end