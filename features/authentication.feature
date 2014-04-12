Feature: Some terse yet descriptive text of what is desired
  In order to access calendar details
  A user with a google account
  Should be able to authenticate using that account

  @localhost_request
  Scenario: Successful authentication
  	Given that I have mocked a successful google authentication
    When I go to the dashboard
      And I sign in correctly with google
    Then I should see a list of my calendars
