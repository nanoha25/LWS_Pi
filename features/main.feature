# Created by shirasaki at 21/9/17
Feature: As a user
  I want to use a device to gather my body fat data and display it in a device or through a webpage
  so that I can keep track on it.

  Scenario: Measure the body fat
    Given I have a weight scale capable of measuring body fat
    When I stand on that weight scale
    Then I should be present with body fat data

  Scenario: Transmit the data
    Given My weight scale has bluetooth connection capability
    When The scale acquires my body fat data
    Then The scale will send the data to another device

  Scenario: Display the data
    Given I install an app on my device
    When I open the app
    Then I will see my body fat data
