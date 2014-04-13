@successful_google_authentication
Feature: As an organised user I want to add notes to my events
  In order to prepare for their day
  A busy person who uses google calendar
  Should be able to create private notes for their events

  @todays_event_list
  Scenario: Adding a note to an event
    Given I have something going on today
    When I sign in and view the day's details on my main calendar
    Then I should be able to add a note to the first calendar item
      And see it again if I reload the page

  # Scenario: Scenario: Adding a note to an instance of a recurring event