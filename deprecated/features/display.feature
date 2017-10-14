# Created by hakur at 22/09/2017
Feature: Display the body fat data
  As a user
  I want to browse my body fat data on my device (such as smartphone)
  So that I can review them and better track my health condition

  Scenario: Use the app to display the data
    Given I have a smartphone with iOS
    When I open the accompanying app
    Then I can see my latest body fat data

  Scenario: Use the app to search the weight scale actively
    Given I open the accompanying app
    When I tap the search button
    Then The app will actively search the scale

  Scenario: Use the app to review history data
    Given I open the accompanying app
    When I tap the history button
    Then I can see history data in a period

  Scenario: Use the app to filter bad data
    Given I open the accompanying app
    When I tap the filter button
    Then I will not see missing or wrong data