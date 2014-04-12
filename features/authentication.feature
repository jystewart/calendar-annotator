Feature: Users need to be able to provide access to their calendars
  In order to access calendar details
  A user with a google account
  Should be able to authenticate using that account

  @successful_calendar_list @successful_google_authentication
  Scenario: Successful authentication
    When I go to the dashboard
      And I sign in correctly with google
    Then I should see a list of my calendars

  @failed_google_authentication
  Scenario: Unsuccessful authentication
    When I go to the dashboard
      And I fail to sign in correctly or I refuse permission
    Then I should get a friendly error message explaining my folly
